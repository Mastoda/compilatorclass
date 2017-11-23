#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "hash.h"

#define HT_SIZE 1024

hashtable_t *ht_create(void)
{
	hashtable_t *hashtable = calloc(HT_SIZE, sizeof(hashtable_t));

	if (!hashtable)
		exit(1);

	return hashtable;
}

static int ht_calc(char *slot)
{
	int i;
	int ht_index = 1;

	for (i = 0; i < strlen(slot); i++)
		ht_index = (ht_index * slot[i]) % HT_SIZE + 1;

	return ht_index - 1;
}

hashtable_t *ht_set(hashtable_t *hashtable, char *slot, int code)
{
	if (ht_get(hashtable, slot, code))
		return;

	int ht_index = ht_calc(slot);
	hashtable_t *curr_hash = &hashtable[ht_index];

	/* it goes after last element at given slot */
	for( 
		; 
		curr_hash->next; 
		curr_hash = curr_hash->next
	);

	/* if slot occupied, a new element is created */
	if (curr_hash->slot) {
		curr_hash->next = calloc(1, sizeof(hashtable_t));
		curr_hash = curr_hash->next;
	}

	curr_hash->slot = calloc(1, strlen(slot) + 1);
	strcpy(curr_hash->slot, slot);
	curr_hash->code = code;

	return curr_hash;
}

hashtable_t *ht_get(hashtable_t *hashtable, char *slot, int code)
{
	hashtable_t *curr_hash = &hashtable[ht_calc(slot)];

	if (!curr_hash->slot)
		return 0;

	for (
		; 
		curr_hash->next && (strcmp(slot, curr_hash->slot) || code != curr_hash->code);
		curr_hash=curr_hash->next
	);

	if (strcmp(curr_hash->slot, slot) || code != curr_hash->code)
		return 0;

	return curr_hash;
}

void ht_print(hashtable_t *hashtable)
{

	int i;

	printf("Hash Table: \n---------------------\n");

	for(i = 0; i < HT_SIZE; i++) {

		hashtable_t *curr_hash = &hashtable[i];

		if (curr_hash->slot) {

			for ( ; curr_hash->next; curr_hash = curr_hash->next)
				printf("[%i][%i]: [%s]\n", i, curr_hash->code, curr_hash->slot);

			if (curr_hash->slot)
				printf("[%i][%i]: [%s]\n", i, curr_hash->code, curr_hash->slot);
		}
	}
}

