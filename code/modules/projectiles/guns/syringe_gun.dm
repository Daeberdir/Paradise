/obj/item/gun/projectile/revolver/syringe
	name = "syringe gun"
	desc = "A spring loaded rifle designed to fit syringes, used to incapacitate unruly patients from a distance."
	icon_state = "syringegun"
	item_state = "syringegun"
	origin_tech = "combat=2;biotech=3"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/syringe
	throw_speed = 3
	throw_range = 7
	force = 4
	materials = list(MAT_METAL=2000)
	clumsy_check = 0
	fire_sound = 'sound/items/syringeproj.ogg'
/*
/obj/item/gun/projectile/revolver/syringe/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/caseless/syringe(src)

/obj/item/gun/projectile/revolver/syringe/process_chamber()
	if(!length(syringes) || chambered.BB)
		return

	var/obj/item/reagent_containers/syringe/S = syringes[1]
	if(!S)
		return

	chambered.BB = new S.ammo_casing(src)
	S.reagents.trans_to(chambered.BB, S.reagents.total_volume)
	chambered.BB.name = S.name

	syringes.Remove(S)
	qdel(S)

/obj/item/gun/projectile/revolver/syringe/afterattack(atom/target, mob/living/user, flag, params)
	if(target == loc)
		return
	..()

/obj/item/gun/projectile/revolver/syringe/examine(mob/user)
	. = ..()
	var/num_syringes = chambered.BB
	. += span_notice("Can hold [max_syringes] syringe\s. Has [num_syringes] syringe\s remaining.")

/obj/item/gun/projectile/revolver/syringe/attack_self(mob/living/user)
	if(!length(syringes) && !chambered.BB)
		balloon_alert(user, "уже разряжено!")
		return FALSE

	var/obj/item/reagent_containers/syringe/S
	if(chambered.BB) // Remove the chambered syringe first
		S = new()
		chambered.BB.reagents.trans_to(S, chambered.BB.reagents.total_volume)
		qdel(chambered.BB)
		chambered.BB = null
	else
		S = syringes[length(syringes)]

	user.put_in_hands(S)
	syringes.Remove(S)
	process_chamber()
	balloon_alert(user, "шприц разряжен!")
	return TRUE

/obj/item/gun/projectile/revolver/syringe/attackby(obj/item/A, mob/user, params, show_msg = TRUE)
	if(istype(A, /obj/item/reagent_containers/syringe))
		var/in_clip = length(syringes) + (chambered.BB ? 1 : 0)
		if(in_clip < max_syringes)
			if(!user.drop_transfer_item_to_loc(A, src))
				return
			balloon_alert(user, "заряжено!")
			syringes.Add(A)
			process_chamber() // Chamber the syringe if none is already
			return TRUE
		else
			balloon_alert(user, "недостаточно места!")
	else
		return ..()
*/
/obj/item/gun/projectile/revolver/syringe/rapidsyringe
	name = "rapid syringe gun"
	desc = "A modification of the syringe gun design, using a rotating cylinder to store up to six syringes."
	icon_state = "rapidsyringegun"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/syringe/rapid

/obj/item/gun/projectile/revolver/syringe/syndicate
	name = "dart pistol"
	desc = "A small spring-loaded sidearm that functions identically to a syringe gun."
	icon_state = "syringe_pistol"
	item_state = "gun" //Smaller inhand
	w_class = WEIGHT_CLASS_SMALL
	origin_tech = "combat=2;syndicate=2;biotech=3"
	force = 2 //Also very weak because it's smaller
	suppressed = TRUE //Softer fire sound
	can_unsuppress = FALSE //Permanently silenced

/obj/item/gun/projectile/revolver/syringe/blowgun
	name = "blowgun"
	desc = "Fire syringes at a short distance."
	icon_state = "blowgun"
	item_state = "blowgun"
	fire_sound = 'sound/items/blowgunproj.ogg'

/obj/item/gun/projectile/revolver/syringe/blowgun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	visible_message(span_danger("[user] starts aiming with a blowgun!"))
	if(do_after(user, 1.5 SECONDS, src))
		user.apply_damages(oxy = 20, stamina = 20)
		..()

