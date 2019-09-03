
#include <lib/x86.h>
#include "import.h"

#define DIR_MASK    0xffc00000
#define PAGE_MASK   0x003ff000
#define OFFSET_MASK 0x00000fff
#define DIR_SHIFT   22
#define PAGE_SHIFT  12
#define VM_USERLO 0x40000000
#define VM_USERHI 0xF0000000
#define VM_USERLO_PI  (VM_USERLO / PAGESIZE)   // VM_USERLO page index
#define VM_USERHI_PI  (VM_USERHI / PAGESIZE)   // VM_USERHI page index
#define PERM_USER (PTE_P | PTE_W)
#define PERM_KERNEL (PTE_P | PTE_W | PTE_G)
#define PT_PERM_PTU (PTE_P | PTE_W | PTE_U)
#define PERMISSION_OUT_MASK 0xFFFFF000


/** ASSIGNMENT INFO:
  * - Here we perform the virtual address translation based on 2 level paging.
  * - Remember that a 32-bit virtual address is divided into directory, page and offset fields.
  * |31       22|21    12|11    0|
  * |-----------|--------|-------|
  * | DIR       |  PAGE  | OFFSET|
  */

/** TASK 1:
  * * Return the page directory entry corresponding to the given virtual address
  *   according to the page structure of process # [proc_index].
  *
  * Hint 1: Extract the page directory index and page table index from vaddr.
  *         Use the masks defined above. (Do think of what the values are.)
  * Hint 2: Use the appropriate functions in MATIntro layer to
  *         read the pdir_entry
  */
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  // TODO
  unsigned int pde_index = vaddr & DIR_MASK;
  unsigned int pte_index = vaddr & PAGE_MASK;
  return get_pdir_entry(proc_index ,pde_index);


}

/** TASK 2:
  * * Return the page table entry corresponding to the virtual address,
  * - Return 0 if the mapping does not exist in page directory entry (i.e. pde = 0).
  *
  * Hint 1: Same as TASK 1.
  */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  // TODO
  unsigned int pde_index = vaddr & DIR_MASK;
  unsigned int pte_index = vaddr & PAGE_MASK;
  if (pde_index == 0) return 0;
  return get_ptbl_entry(proc_index , pde_index , pte_index);




}

/** TASK 3:
  * * Remove the page directory entry for the given virtual address
  * Hint 1: Calculate the arguments required by the function(rmv_pdir_entry) in MPTIntro layer
  *         and simply call it.
  */
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  // TODO

  unsigned int pde_index =  vaddr & DIR_MASK;
  rmv_pdir_entry(proc_index , pde_index);



}

/** TASK 4:
  * * Remove the page table entry for the given virtual address
  * Hint 1: Same as TASK 3. Use the correct function.
  */
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  // TODO
  unsigned int pde_index = vaddr & DIR_MASK;
  unsigned int pte_index = vaddr & PAGE_MASK;
  rmv_ptbl_entry(proc_index , pde_index , pte_index);




}

/** TASK 5:
  * * Register the mapping from the virtual address [vaddr] to physical page # [page_index] in the page directory.
  * Hint: Same as TASK 3. Use the correct function.
  */
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index)
{
  // TODO
  unsigned int pde_index = vaddr & DIR_MASK;
  set_pdir_entry(proc_index , pde_index , page_index);




}

/** TASK 6:
  * * Register the mapping from the virtual address [vaddr] to the physical page # [page_index] with permission [perm]
  * - You do not need to worry about the page directory entry. just map the page table entry.
  * Hint: Same as TASK 3. Use the correct function.
  */
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr, unsigned int page_index, unsigned int perm)
{
  // TODO
  unsigned int pde_index = vaddr & DIR_MASK;
  unsigned int pte_index = vaddr & PAGE_MASK;

  set_ptbl_entry(proc_index , pde_index , pte_index , page_index , perm);


}

/** TASK 7:
  * * Initialize the identity page table
  * - Set all the entries of IDPTbl.
  * - The permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
  *   while the permission for the rest should be PTE_P and PTE_W.
  * Hint 1: Review MATIntro layer.
  *         - The entire addresses < VM_USERLO or >= VM_USERHI are reserved by the kernel.
  * Hint 2: You have already created the functions that deal with IDPTbl.
  *         Calculate the appropriate permission values as mentioned above
  *         and call set_ptbl_entry_identity from MATIntro layer.
  */
void idptbl_init(unsigned int mbi_adr)
{
  // TODO: define your local variables here.
  int row,col;



  container_init(mbi_adr);

  // TODO

  for(row = 0 ; row < 1024 ; row ++)
  {
    for(col = 0 ; col < 1024 ; col ++)
    {
      if(row < VM_USERLO_PI || row >= VM_USERHI_PI)
      {
        set_ptbl_entry_identity(row , col , PERM_KERNEL);
      }
      else
      {
        set_ptbl_entry_identity(row , col, PERM_USER);
      }
    }
  }
  
  

  



}
