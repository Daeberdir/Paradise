/obj/mecha/medical
	turnsound = 'sound/mecha/mechmove01.ogg'
	stepsound = 'sound/mecha/mechstep.ogg'
	compatibility = MODULE_COMPATIBILITY_COMBAT|MODULE_COMPATIBILITY_JAW|MODULE_COMPATIBILITY_BOOSTER

/obj/mecha/medical/New()
	..()
	trackers += new /obj/item/mecha_parts/mecha_tracking(src)
