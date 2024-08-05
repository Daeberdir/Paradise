/**
  * A holder for simple behaviour that can be attached to many different types
  *
  * Only one element of each type is instanced during game init.
  * Otherwise acts basically like a lightweight component.
  */
/datum/element
	/// Option flags for element behaviour
	var/element_flags = NONE
	/**
	  * The index of the first attach argument to consider for duplicate elements
	  *
	  * Is only used when flags contains [ELEMENT_BESPOKE]
	  *
	  * This is infinity so you must explicitly set this
	  */
	var/id_arg_index = INFINITY

/// Activates the functionality defined by the element on the given target datum
/datum/element/proc/Attach(datum/target)
	SHOULD_CALL_PARENT(1)
	if(type == /datum/element)
		return ELEMENT_INCOMPATIBLE
	SEND_SIGNAL(target, COMSIG_ELEMENT_ATTACH, src)
	if(element_flags & ELEMENT_DETACH_ON_HOST_DESTROY)
		RegisterSignal(target, COMSIG_QDELETING, PROC_REF(Detach), override = TRUE)

/// Deactivates the functionality defines by the element on the given datum
/datum/element/proc/Detach(datum/source, force)
	SEND_SIGNAL(source, COMSIG_ELEMENT_DETACH, src)
	SHOULD_CALL_PARENT(1)
	UnregisterSignal(source, COMSIG_QDELETING)

/datum/element/Destroy(force)
	if(!force)
		return QDEL_HINT_LETMELIVE
	SSdcs.elements_by_type -= type
	return ..()

//DATUM PROCS

/// Finds the singleton for the element type given and attaches it to src
/datum/proc/_AddElement(list/arguments)
	if(QDELING(src))
		var/datum/element/element_type = arguments[1]
		stack_trace("We just tried to add the element [element_type] to a qdeleted datum, something is fucked")
		return
	var/datum/element/ele = SSdcs.GetElement(arguments)
	if(!ele) // We couldn't fetch the element, likely because it was not an element.
		return // the crash message has already been sent
	arguments[1] = src
	if(ele.Attach(arglist(arguments)) == ELEMENT_INCOMPATIBLE)
		CRASH("Incompatible [arguments[1]] assigned to a [type]! args: [json_encode(args)]")

/**
  * Finds the singleton for the element type given and detaches it from src
  * You only need additional arguments beyond the type if you're using [ELEMENT_BESPOKE]
  */
/datum/proc/_RemoveElement(list/arguments)
	var/datum/element/ele = SSdcs.GetElement(arguments, init_element = FALSE)
	if(!ele) // We couldn't fetch the element, likely because it didn't exist.
		return
	ele.Detach(src)
