#ifndef _HASH
#define _HASH

typedef struct hashtable_s
{
	char *value;
	int code;
	struct hashtable_s *next;
} hashtable_t;

hashtable_t *ht_create(void);
hashtable_t *ht_get(hashtable_t *hash, char *value, int code);
int ht_calc(char *value);
void ht_set(hashtable_t *hash, char *value, int code);
void ht_print(hashtable_t *hash);

#endif
