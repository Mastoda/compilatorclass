#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hash.h"

#define HT_SIZE 993

hashtable_t
*ht_create(void)
{
	hashtable_t *hashtable = calloc(HT_SIZE, sizeof(hashtable_t));

	if (!hashtable)
		exit(1);

	return hashtable;
}

int
ht_calc(char *value)
{
	int i;
	int ht_index = 1;

	for (i = 0; i < strlen(value); i++)
		ht_index = (ht_index * value[i]) % HT_SIZE + 1;

	return ht_index - 1;
}

hashtable_t *
ht_set(hashtable_t *hash, char *value, int code)
{
	if (ht_get(hash, value, code))
		return;

	int ht_index = ht_calc(value);
	hashtable_t *curr_hash = &hash[ht_index];

	for (; curr_hash->next; curr_hash = curr_hash->next);

	if (curr_hash->value) {
		curr_hash->next = calloc(1, sizeof(hashtable_t));
		curr_hash = curr_hash->next;
	}

	curr_hash->value = calloc(1, strlen(value) + 1);
	strcpy(curr_hash->value, value);
	curr_hash->code = code;

	return curr_hash;
}

hashtable_t
*ht_get(hashtable_t *hash, char *value, int code)
{
	hashtable_t *curr_hash = &hash[ht_calc(value)];

	if (!curr_hash->value)
		return 0;

	for (; curr_hash->next && (strcmp(value, curr_hash->value) || code != curr_hash->code);
			curr_hash=curr_hash->next);

	if (strcmp(curr_hash->value, value) || code != curr_hash->code)
		return 0;

	return curr_hash;
}

void
ht_print(hashtable_t *hash)
{

	int i;

	printf("Hash Table \n---------------------------\n");

	for(i = 0; i < HT_SIZE; i++) {

		hashtable_t *curr_hash = &hash[i];

		if (curr_hash->value) {

			for (; curr_hash->next; curr_hash = curr_hash->next)
				printf("hash[%i][%i]: [%s]\n", i, curr_hash->code, curr_hash->value);

			if (curr_hash->value)
				printf("hash[%i][%i]: [%s]\n", i, curr_hash->code, curr_hash->value);
		}
	}
}

