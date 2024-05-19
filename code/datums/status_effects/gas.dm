/datum/status_effect/freon
	id = "frozen"
	duration = 100
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /obj/screen/alert/status_effect/freon
	var/icon/cube
	var/ice_state = "ice_cube"
	var/can_melt = TRUE

/obj/screen/alert/status_effect/freon
	name = "Frozen Solid"
	desc = "You're frozen inside an ice cube, and cannot move! You can still do stuff, like shooting. Resist out of the cube!"
	icon_state = "frozen"

/datum/status_effect/freon/on_apply()
	RegisterSignal(owner, COMSIG_LIVING_RESIST, PROC_REF(owner_resist))
	RegisterSignal(owner, COMSIG_HUMAN_APPLY_OVERLAY, PROC_REF(update_overlay))
	if(!owner.stat)
		to_chat(owner, "<span class='userdanger'>You become frozen in a cube!</span>")
	cube = icon('icons/effects/freeze.dmi', ice_state)
	owner.add_overlay(cube)
	owner.update_canmove()
	return ..()

/datum/status_effect/freon/tick()
	owner.update_canmove()
	if(can_melt && owner.bodytemperature >= BODYTEMP_NORMAL)
		qdel(src)

/datum/status_effect/freon/proc/update_overlay()
	if(!owner)
		return
	owner.cut_overlay(cube)
	owner.add_overlay(cube)

/datum/status_effect/freon/proc/owner_resist()
	to_chat(owner, "You start breaking out of the ice cube!")
	if(do_after(owner, 4 SECONDS, owner, NONE))
		if(!QDELETED(src))
			to_chat(owner, "You break out of the ice cube!")
			owner.remove_status_effect(/datum/status_effect/freon)
			owner.update_canmove()

/datum/status_effect/freon/on_remove()
	if(!owner.stat)
		to_chat(owner, "The cube melts!")
	owner.cut_overlay(cube)
	owner.adjust_bodytemperature(100)
	owner.update_canmove()
	UnregisterSignal(owner, COMSIG_LIVING_RESIST)
	UnregisterSignal(owner, COMSIG_HUMAN_APPLY_OVERLAY)

/datum/status_effect/freon/watcher
	duration = 15
	can_melt = FALSE
