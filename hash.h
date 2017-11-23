#ifndef _HASH
#define _HASH

typedef struct _hashtable_s
{
	char *slot;
	int code;
	struct _hashtable_s *next;
} hashtable_t;

hashtable_t *ht_create(void);
hashtable_t *ht_get(hashtable_t *hashtable, char *slot, int code);
hashtable_t *ht_set(hashtable_t *hashtable, char *slot, int code);

void ht_print(hashtable_t *hashtable);

#endif
