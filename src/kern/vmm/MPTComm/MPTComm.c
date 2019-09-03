#include <lib/x86.h>


#include "import.h"
#define VM_USERLO 0x40000000
#define VM_USERHI 0xF0000000
#define VM_USERLO_PI  (VM_USERLO / PAGESIZE)   // VM_USERLO page index
#define VM_USERHI_PI  (VM_USERHI / PAGESIZE)   // VM_USERHI page index
#define PERM_USER (PTE_P | PTE_W)
#define PERM_KERNEL (PTE_P | PTE_W | PTE_G)
#define PT_PERM_PTU (PTE_P | PTE_W | PTE_U)
#define PERMISSION_OUT_MASK 0xFFFFF000




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
    int i,j;

    idptbl_init(mbi_adr);

    // TODO
    for(i=0 ; i < NUM_IDS ; i++)
    {
      for (j = 0 ; j < 1024 ; j++)
      {
        if(j < VM_USERLO_PI || j >= VM_USERHI_PI)
        {
          set_pdir_entry_identity(i , j);
        }
        else
        {
          rmv_pdir_entry(i , j);
        }
        
      }
    }






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
  unsigned int pg_index;
  pg_index = container_alloc(proc_index);
  if(pg_index > 0)
  {
    set_pdir_entry_by_va(proc_index,vadr,pg_index);
    rmv_ptbl_entry_by_va(proc_index , vadr);
    return pg_index;
  }
  return 0;








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
  unsigned int pde = get_pdir_entry_by_va(proc_index , vadr);
  rmv_pdir_entry_by_va(proc_index , vadr);
  container_free(proc_index , get_ptbl_entry_by_va(proc_index , vadr));






}
