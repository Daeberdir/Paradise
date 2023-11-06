//Ponchos!

/obj/item/clothing/neck/poncho
	name = "classic poncho"
	desc = "It can protect you from the scorching sun and save your strength in the desert. You can buy one of these for a fistful of credits."
	icon_state = "classicponcho"
	var/flipped = FALSE
	item_color = "classic"
	sprite_sheets = list(
		"Drask" = 'icons/mob/clothing/species/drask/neck.dmi',
		"Grey" = 'icons/mob/clothing/species/grey/neck.dmi',
		"Kidan" = 'icons/mob/clothing/species/kidan/neck.dmi',
		"Monkey" = 'icons/mob/clothing/species/monkey/neck.dmi',
		"Farwa" = 'icons/mob/clothing/species/monkey/neck.dmi',
		"Wolpin" = 'icons/mob/clothing/species/monkey/neck.dmi',
		"Neara" = 'icons/mob/clothing/species/monkey/neck.dmi',
		"Stok" = 'icons/mob/clothing/species/monkey/neck.dmi',
		"Plasmaman" = 'icons/mob/clothing/species/plasmaman/neck.dmi',
		"Unathi" = 'icons/mob/clothing/species/unathi/neck.dmi',
		"Ash Walker" = 'icons/mob/clothing/species/unathi/neck.dmi',
		"Ash Walker Shaman" = 'icons/mob/clothing/species/unathi/neck.dmi',
		"Draconid" =  'icons/mob/clothing/species/unathi/neck.dmi',
		"Vox" = 'icons/mob/clothing/species/vox/neck.dmi',
		"Wryn" = 'icons/mob/clothing/species/wryn/neck.dmi'
	)

/obj/item/clothing/neck/poncho/AltClick(mob/living/carbon/human/user)
	if(!iscarbon(user))
		..()
	else if(user.neck != src)
		..()
	else
		flip(user)

/obj/item/clothing/neck/poncho/verb/flip_poncho(mob/living/carbon/human/user = usr)
	set name = "Flip poncho"
	set category = "Object"
	set desc = "Flip poncho behind your back"

	if(!iscarbon(user))
		return
	if(user.neck != src)
		to_chat(user, span_warning("Poncho must be equipped before flipping!"))
		return
	flip(user)

/obj/item/clothing/neck/poncho/proc/flip(mob/user)
	if(user.incapacitated())
		to_chat(user, span_warning("You can't do that right now!"))
		return
	flipped = !flipped
	if(flipped)
		icon_state = "[item_color]poncho_flip"
		to_chat(user, "You flip [src] behind your back.")
	else
		icon_state = "[item_color]poncho"
		to_chat(user, "You flip [src] back in normal position.")
	user.update_inv_neck()

/obj/item/clothing/neck/poncho/red
	name = "red poncho"
	desc = "It is a red dead color. It makes you look like a rascal."
	icon_state = "redponcho"
	item_color = "red"

/obj/item/clothing/neck/poncho/orange
	name = "orange poncho"
	desc = "This one in particular is especially nice for fooling around in."
	icon_state = "orangeponcho"
	item_color = "orange"

/obj/item/clothing/neck/poncho/yellow
	name = "yellow poncho"
	desc = "A souvenir shop curio straight from New New Mexico. Hola, Amigo!"
	icon_state = "yellowponcho"
	item_color = "yellow"

/obj/item/clothing/neck/poncho/green
	name = "green poncho"
	desc = "The lines on the cloth continue the mustache line quite well."
	icon_state = "greenponcho"
	item_color = "green"

/obj/item/clothing/neck/poncho/Blue
	name = "blue poncho"
	desc = "Every bounty hunter's modern day outfit. Well conceals holster, ammunition loadout, body armor, scabbard, a pair of handguns, sawed-off shotgun and grenades."
	icon_state = "blueponcho"
	item_color = "blue"

/obj/item/clothing/neck/poncho/purple
	name = "purple poncho"
	desc = "The case when modern designers butchered the classics."
	icon_state = "purpleponcho"
	item_color = "purple"

/obj/item/clothing/neck/poncho/white
	name = "white poncho"
	desc = "An exact replica of the most famous gunfighter on the New Frontier. The one who was shot in a gunfight."
	icon_state = "whiteponcho"
	item_color = "white"

/obj/item/clothing/neck/poncho/black
	name = "black poncho"
	desc = "Label states, \"Do not ride your horse faster than 88 miles per hour to avoid breaking the time loop.\""
	icon_state = "blackponcho"
	item_color = "black"

/obj/item/clothing/neck/poncho/ponchoshame
	name = "poncho of shame"
	desc = "Forced to live on your shameful acting as a fake Mexican, you and your poncho have grown inseperable. Literally."
	icon_state = "shameponcho"
	item_color = "shame"
	flags = NODROP

/obj/item/clothing/neck/poncho/security
	name = "corporate poncho"
	desc = "Пончо в корпоративных цветах, при его виде пропадает желание нелегально пересекать сектор"
	icon_state = "secponcho"
	item_color = "sec"

/obj/item/clothing/neck/poncho/mime
	name = "black and white poncho"
	desc = "The motley patterns unfold throughout the garment, forming the outline of a skull on the back."
	icon_state = "mimeponcho"
	item_color = "mime"

/obj/item/clothing/neck/poncho/rainbow
	name = "multicolored poncho"
	desc = "Popular among pacifists and other drug addicts."
	icon_state = "rainbowponcho"
	item_color = "reinbow"

/obj/item/clothing/neck/poncho/tactical
	name = "tactical poncho"
	desc = "A short and black poncho for some tactical operations in hot areas of space"
	icon_state = "tacticalponcho"
	item_color = "tactical"
