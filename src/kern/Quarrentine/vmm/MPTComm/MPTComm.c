#include <lib/x86.h>

#include "import.h"





/** TASK 1:
  * * For each process from id 0 to NUM_IDS -1,
  *   set the page directory entries so that the kernel portion of the map as identity map,
  *   and the rest of page directories are unmmaped.
  *
  * Hint 1: Recall which portions are reserved for the kernel and calculate the pde_index.
  * Hint 2: Recall which function in MPTIntro layer is used to set identity map. (See import.h)
  * Hint 3: Remove the page directory entry to unmap it.
  */
void pdir_init(unsigned int mbi_adr)
{
    // TODO: define your local variables here.

    idptbl_init(mbi_adr);

    // TODO






}

/** TASK 2:
  * * 1. Allocate a page (with container_alloc) for the page table,
  * * 2. Check if the page was allocated and register the allocated page in page directory for the given virtual address.
  * * 3. Clear (set to 0) all the page table entries for this newly mapped page table.
  * * 4. Return the page index of the newly allocated physical page.
  * 	 In the case when there's no physical page available, it returns 0.
  */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vadr)
{
  // TODO









}

/** TASK 3:
  * * Reverse operation of alloc_ptbl.
  *   - Remove corresponding page directory entry
  *   - Free the page for the page table entries (with container_free).
  * Hint 1: Find the pde corresponding to vadr (MPTOp layer)
  * Hint 2: Remove the pde (MPTOp layer)
  * Hint 3: Use container free
  */
void free_ptbl(unsigned int proc_index, unsigned int vadr)
{
  // TODO






}
