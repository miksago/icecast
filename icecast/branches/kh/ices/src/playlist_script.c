/* playlist_script.c
 * - Gets a filename to play back based on output from a program/shell script
 *   run each time.
 *
 * $Id: playlist_script.c,v 1.4 2002/08/09 13:59:02 msmith Exp $
 *
 * Copyright (c) 2001 Michael Smith <msmith@labyrinth.net.au>
 *
 * This program is distributed under the terms of the GNU General
 * Public License, version 2. You may use, modify, and redistribute
 * it under the terms of this license. A copy should be included
 * with this source.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

#include "cfgparse.h"
#include "inputmodule.h"
#include "im_playlist.h"

#define MODULE "playlist-script/"
#include "logging.h"

typedef struct {
    char *program;
} script_playlist;

static void playlist_script_clear(void *data) {
    if(data)
        free(data);
}

static char *playlist_script_get_filename(void *data) {
    script_playlist *pl = data;
    char *prog = pl->program;
    FILE *pipe;
    char *buf = calloc(1,1024);

    if(!buf)
        return NULL;

    pipe = popen(prog, "r");

    if(!pipe) {
        LOG_ERROR1("Couldn't open pipe to program \"%s\"", prog);
        return NULL;
    }

    if(fgets(buf, 1024, pipe) == NULL) {
        LOG_ERROR1("Couldn't read filename from pipe to program \"%s\"", prog);
        free(buf);
        pclose(pipe);
        return NULL;
    }

    pclose(pipe);

    if(buf[0] == '\n' || (buf[0] == '\r' && buf[1] == '\n')) {
        LOG_ERROR1("Got newlines instead of filename from program \"%s\"", prog);
        free(buf);
        return NULL;
    }

    if(buf[strlen(buf)-1] == '\n')
        buf[strlen(buf)-1] = 0;
    else
        LOG_WARN1("Retrieved overly long filename \"%s\" from script, this may fail", buf);

    /* De-fuck windows filenames. */
    if(strlen(buf) > 0 && buf[strlen(buf)-1] == '\r')
        buf[strlen(buf)-1] = 0;

    LOG_DEBUG2("Program/script (\"%s\") returned filename \"%s\"", prog, buf);

    return buf;
}

static void playlist_script_free_filename(void *data __attribute__((unused)), char *fn)
{
    free(fn);
}

int playlist_script_initialise(module_param_t *params, struct playlist_state *pl)
{
    script_playlist *data;

    pl->get_filename = playlist_script_get_filename;
    pl->clear = playlist_script_clear;
    pl->free_filename = playlist_script_free_filename;
    pl->sleep = 1;

    pl->data = calloc(1, sizeof(script_playlist));
    if(!pl->data)
        return -1;

    data = (script_playlist *)pl->data;

    while(params != NULL) {
        if(!strcmp(params->name, "program")) {
            if(data->program) free(data->program);
            data->program = params->value;
        }
        else if(!strcmp(params->name, "type")) {
            /* We ignore this one */
        }
        else if(!strcmp(params->name, "sleep"))
            pl->sleep = atoi(params->value);
        else
            LOG_WARN1("Unknown parameter to playlist script module: %s",
                    params->name);
        params = params->next;
    }

    if(!data->program) {
        LOG_ERROR0("No program name specified for playlist module");
        free(data);
        return -1;
    }

    return 0;
}

