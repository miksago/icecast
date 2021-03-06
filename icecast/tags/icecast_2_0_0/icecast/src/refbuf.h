/* refbuf.h
**
** reference counting data buffer
**
*/
#ifndef __REFBUF_H__
#define __REFBUF_H__

typedef struct _refbuf_tag
{
    char *data;
    long len;

    unsigned long _count;
} refbuf_t;

typedef struct _refbuf_queue_tag
{
    refbuf_t *refbuf;
    long total_length;
    
    struct _refbuf_queue_tag *next;
} refbuf_queue_t;

void refbuf_initialize(void);
void refbuf_shutdown(void);

refbuf_t *refbuf_new(unsigned long size);
void refbuf_addref(refbuf_t *self);
void refbuf_release(refbuf_t *self);

void refbuf_queue_add(refbuf_queue_t **queue, refbuf_t *refbuf);
refbuf_t *refbuf_queue_remove(refbuf_queue_t **queue);
void refbuf_queue_insert(refbuf_queue_t **queue, refbuf_t *refbuf);

/* Size in buffers */
int refbuf_queue_size(refbuf_queue_t **queue);
/* Size in bytes */
int refbuf_queue_length(refbuf_queue_t **queue);

#endif  /* __REFBUF_H__ */








