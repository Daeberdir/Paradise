GLOBAL_LIST_INIT(lenses_blacklist, list(/obj/item/clothing/glasses/welding/superior, /obj/item/clothing/glasses/sunglasses/blindfold, /obj/item/clothing/glasses/meson/cyber, \
										/obj/item/clothing/glasses/eyepatch, /obj/item/clothing/glasses/monocle, /obj/item/clothing/glasses/material/cyber,/obj/item/clothing/glasses/material/lighting, \
										/obj/item/clothing/glasses/sunglasses_fake/holo, /obj/item/clothing/glasses/sunglasses/lasers, /obj/item/clothing/glasses/thermal/cyber, \
										/obj/item/clothing/glasses/godeye, /obj/item/clothing/glasses/sunglasses/blindfold/cucumbermask))

/obj/item/clothing/glasses/hud/tajblind
	name = "embroidered veil"
	desc = "An Ahdominian made veil that allows the user to see while obscuring their eyes."
	icon_state = "tajblind"
	item_state = "tajblind"
	prescription_upgradable = FALSE //Just for a while let it be here.
	flash_protect = 1
	tint = 3
	actions_types = list(/datum/action/item_action/toggle_veil)
	flags_cover = GLASSESCOVERSEYES
	var/global/list/jobs[0]
	var/obj/item/clothing/glasses/lenses
	sprite_sheets = list(
		"Vox" = 'icons/mob/species/vox/eyes.dmi',
		"Grey" = 'icons/mob/species/grey/eyes.dmi',
		"Monkey" = 'icons/mob/species/monkey/eyes.dmi',
		"Farwa" = 'icons/mob/species/monkey/eyes.dmi',
		"Wolpin" = 'icons/mob/species/monkey/eyes.dmi',
		"Neara" = 'icons/mob/species/monkey/eyes.dmi',
		"Stok" = 'icons/mob/species/monkey/eyes.dmi'
		)

/obj/item/clothing/glasses/hud/tajblind/New()
	. = ..()
	toggle_veil()

/obj/item/clothing/glasses/hud/tajblind/ui_action_click(mob/user, actiontype)
	if(ispath(actiontype, /datum/action/item_action/toggle_veil))
		toggle_veil()
		return TRUE

/obj/item/clothing/glasses/hud/tajblind/proc/toggle_veil()
	if(usr.canmove && !usr.incapacitated())
		up = !up
		flash_protect ^= initial(flash_protect)
		tint ^= initial(tint)
		var/mob/living/carbon/user = usr
		user.update_tint()
		user.update_inv_glasses()

/obj/item/clothing/glasses/hud/tajblind/item_action_slot_check(slot)
	if(slot == slot_glasses)
		return TRUE

/obj/item/clothing/glasses/hud/tajblind/attackby(var/obj/item/clothing/glasses/glasses, mob/living/user, params)
	if(!user.drop_item())
		to_chat(user, "<span class='notice'>[glasses] is stuck to your hand!</span>")
		return
	if(!(locate(glasses) in GLOB.lenses_blacklist) && !src.lenses)
		see_in_dark = glasses.see_in_dark
		lighting_alpha = glasses.lighting_alpha
		resistance_flags = glasses.resistance_flags
		vision_flags = glasses.vision_flags
		armor = glasses.armor
		scan_reagents = glasses.scan_reagents
		HUDType = glasses.HUDType
		examine_extensions = glasses.examine_extensions
		icon_state = "[glasses.icon_state]_v"
		item_state = "[glasses.item_state]_v"
		actions_types |= glasses.actions_types

		lenses = glasses
		to_chat(usr, "<span class='notice'>You succesfully inserted new lenses in your [src.name]")
	. = ..()

/obj/item/clothing/glasses/hud/tajblind/proc/remove_lenses(/mob/living/user)
	if(lenses)
		to_chat(user, "<span class='notice'>With a simple click you pulled lenses out from [src].</span>")
		see_in_dark = initial(see_in_dark)
		lighting_alpha = initial(lighting_alpha)
		resistance_flags = initial(resistance_flags)
		vision_flags = initial(vision_flags)
		armor = initial(armor)
		scan_reagents = initial(scan_reagents)
		HUDType = initial(HUDType)
		examine_extensions = initial(examine_extensions)
		icon_state = initial(icon_state)
		item_state = initial(item_state)
		actions_types = initial(actions_types)

		lenses.forceMove(user)
		user.put_in_hands(lenses)
		lenses = null

/obj/item/clothing/glasses/hud/tajblind/attack_self(mob/user)
	if(item_state != "tajblind")
		remove_lenses(user)
		user.update_inv_glasses()
	. = ..()

/obj/item/clothing/glasses/hud/tajblind/emp_act(severity)
	if((vision_flags & SEE_MOBS) && istype(src.loc, /mob/living/carbon/human))
		var/mob/living/carbon/human/M = src.loc
		if(M.glasses == src)
			M.EyeBlind(3)
			M.EyeBlurry(5)
			to_chat(M, "<span class='warning'>[src] overloads and blinds you!</span>")
			if(!(NEARSIGHTED in M.mutations))
				M.BecomeNearsighted()
				spawn(100)
				M.CureNearsighted()
	..()
