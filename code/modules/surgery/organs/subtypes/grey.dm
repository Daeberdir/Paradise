/obj/item/organ/internal/liver/grey
	species_type = /datum/species/grey
	name = "grey liver"
	desc = "A small, odd looking liver"
	icon = 'icons/obj/species_organs/grey.dmi'
	alcohol_intensity = 1.6

/obj/item/organ/internal/brain/grey
	species_type = /datum/species/grey
	desc = "A large brain"
	icon = 'icons/obj/species_organs/grey.dmi'
	icon_state = "brain2"
	mmi_icon = 'icons/obj/species_organs/grey.dmi'
	mmi_icon_state = "mmi_full"

/obj/item/organ/internal/brain/grey/insert(mob/living/carbon/M, special = ORGAN_MANIPULATION_DEFAULT)
	. = ..()
	M.add_language(LANGUAGE_GREY)

/obj/item/organ/internal/brain/grey/remove(mob/living/carbon/M, special = ORGAN_MANIPULATION_DEFAULT)
	M.remove_language(LANGUAGE_GREY)
	. = ..()

/obj/item/organ/internal/eyes/grey
	species_type = /datum/species/grey
	name = "grey eyeballs"
	desc = "They still look creepy and emotionless"
	icon = 'icons/obj/species_organs/grey.dmi'
	see_in_dark = 5

/obj/item/organ/internal/heart/grey
	species_type = /datum/species/grey
	name = "grey heart"
	icon = 'icons/obj/species_organs/grey.dmi'

/obj/item/organ/internal/lungs/grey
	species_type = /datum/species/grey
	name = "grey lungs"
	icon = 'icons/obj/species_organs/grey.dmi'

/obj/item/organ/internal/kidneys/grey
	species_type = /datum/species/grey
	name = "grey kidneys"
	icon = 'icons/obj/species_organs/grey.dmi'
