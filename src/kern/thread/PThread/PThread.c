
#include <lib/x86.h>
#include <lib/thread.h>

#include "import.h"

void thread_init(unsigned int mbi_addr)
{
	tqueue_init(mbi_addr);
	set_curid(0);
	tcb_set_state(0, TSTATE_RUN);
}

/** TASK 1:
  * * Allocate new child thread context, set the state of the new child thread
  *   as ready, and push it to the ready queue.
  *   It returns the child thread id.
  *  Hint 1:
  *  - import.h has all the functions you will need.
  *  Hint 2:
  *  - The ready queue is the queue with index NUM_IDS.
  */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
  // TODO
  unsigned int child_id = kctx_new(entry , id , quota);
  
  tcb_set_state(child_id , TSTATE_READY);

  tqueue_enqueue(NUM_IDS , child_id);


  return child_id;
  //return 0;
}

/** TASK 2:
  * * Yield to the next thread in the ready queue. You should:
  *   - Set the currently running thread state as ready,
  *     and push it back to the ready queue.
  *   - Set the state of the poped thread as running
  *   - Set the current thread id
  *   - Then switch to the new kernel context.
  *
  *  Hint 1: The next thread to run is chosen in a round-robin fashion.
  *          i.e. The thread at the head of the ready queue is run next.
  *  Hint 2: If you are the only thread that is ready to run,
  *          do you need to switch to yourself?
  */
void thread_yield(void)
{
  // TODO
  if(tqueue_get_head(NUM_IDS) == NUM_IDS)
  {
    return;
  }
  //set the current running thread state as ready, and push it to the ready queue.
  unsigned int curID = get_curid();
  tcb_set_state(curID , TSTATE_READY);
  tqueue_enqueue(NUM_IDS , curID);

  //pop a thread from the ready queue, set it to running, set it to current thread id.
  unsigned int next_ID = tqueue_dequeue(NUM_IDS);
  tcb_set_state(next_ID , TSTATE_RUN);
  set_curid(next_ID);

  //perform the context switch
  kctx_switch(curID , next_ID);

}


/** TASK 1:
  * * Allocate the forked child thread context, map page structures for the child,
  *   set the state of the new child thread as ready, and push it to the ready queue.
  *   It returns the child thread id.
  *  Hint 1:
  *  - import.h has all the functions you will need.
  *  Hint 2:
  *  - The ready queue is the queue with index NUM_IDS.
  */

uint32_t thread_fork(void *entry, uint32_t id){
    // TODO
  //allocating the forked child thread context
  uint32_t child_id = kctx_fork(entry , id);
  
  //mapping page structure for the child
  map_cow(id , child_id);

  unsigned int child_id_unsigned = (unsigned int) child_id;
  //setting the state of the new child thread as ready
  tcb_set_state(child_id_unsigned , TSTATE_READY);

  //pushing the new child thread into the ready queue
  tqueue_enqueue(NUM_IDS , child_id_unsigned);

  return child_id;
}