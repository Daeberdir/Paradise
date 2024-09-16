//a three-way junction that sorts objects
/obj/structure/disposalpipe/sortjunction
	name = "disposal sorting pipe"
	icon_state = "pipe-j1s"
	base_icon_state = "pipe-j1s"
	flip_type = /obj/structure/disposalpipe/sortjunction/reversed
	initialize_dirs = DISP_DIR_RIGHT|DISP_DIR_FLIP
	/// Look at the list called TAGGERLOCATIONS in /code/_globalvars/lists/flavor_misc.dm
	var/list/sort_tags_list
	/// For mappers. `sort_tags_list` usually list can't be longer than that number.
	var/maxtags = 5


/obj/structure/disposalpipe/sortjunction/Initialize(mapload, obj/structure/disposalconstruct/made_from)
	. = ..()
	update_appearance(UPDATE_NAME|UPDATE_DESC)


/obj/structure/disposalpipe/sortjunction/update_name(updates = ALL)
	. = ..()
	switch(LAZYLEN(sort_tags_list))
		if(0)
			name = "untagged sort junction"
		if(1)
			name = "'[GLOB.TAGGERLOCATIONS[LAZYACCESS(sort_tags_list, 1)]]' sort junction"
		else
			name = "multi-tagged sort junction"


/obj/structure/disposalpipe/sortjunction/update_desc(updates = ALL)
	. = ..()
	desc = "An underfloor disposal pipe with a package sorting mechanism."

	if(!LAZYLEN(sort_tags_list))
		return .

	var/tagnames
	for(var/tag in sort_tags_list)
		tag = uppertext(GLOB.TAGGERLOCATIONS[tag])
		tagnames = "[tag]; [tagnames]"

	tagnames = replacetext(tagnames, ";", ".", length(tagnames))
	desc += "\nIt's tagged with: [tagnames]"


/obj/structure/disposalpipe/sortjunction/attackby(obj/item/I, mob/user, params)
	if(..())
		return

	if(istype(I, /obj/item/destTagger))
		var/obj/item/destTagger/tagger = I

		if(tagger.currTag > 0)	// Tag set
			sort_tags_list = tagger.currTag
			playsound(loc, 'sound/machines/twobeep.ogg', 100, TRUE)
			var/tag = uppertext(GLOB.TAGGERLOCATIONS[tagger.currTag])
			to_chat(user, span_notice("Changed filter to [tag]."))
			update_appearance(UPDATE_NAME|UPDATE_DESC)


/obj/structure/disposalpipe/sortjunction/nextdir(obj/structure/disposalholder/holder)
	var/sortdir = dpdir & ~(dir | REVERSE_DIR(dir))
	if(holder.dir != sortdir) // probably came from the negdir
		if(holder.destinationTag == sort_tags_list) // if destination matches filtered type...
			return sortdir // exit through sortdirection

	// go with the flow to positive direction
	return dir


/obj/structure/disposalpipe/sortjunction/reversed
	icon_state = "pipe-j2s"
	base_icon_state = "pipe-j2s"
	flip_type = /obj/structure/disposalpipe/sortjunction
	initialize_dirs = DISP_DIR_LEFT|DISP_DIR_FLIP


//a three-way junction that sorts objects destined for the mail office mail table (tomail = 1)
/obj/structure/disposalpipe/wrapsortjunction
	name = "disposal mail-sorting pipe"
	desc = "An underfloor disposal pipe which sorts wrapped and unwrapped objects."
	icon_state = "pipe-j1s"
	base_icon_state = "pipe-j1s"
	flip_type = /obj/structure/disposalpipe/wrapsortjunction/reversed
	initialize_dirs = DISP_DIR_RIGHT|DISP_DIR_FLIP


/obj/structure/disposalpipe/wrapsortjunction/nextdir(obj/structure/disposalholder/holder)
	var/sortdir = dpdir & ~(dir | REVERSE_DIR(dir))
	if(holder.dir != sortdir) // probably came from the negdir
		if(holder.tomail) // if destination matches filtered type...
			return sortdir // exit through sortdirection

	// go with the flow to positive direction
	return dir


/obj/structure/disposalpipe/wrapsortjunction/reversed
	icon_state = "pipe-j2s"
	base_icon_state = "pipe-j2s"
	flip_type = /obj/structure/disposalpipe/wrapsortjunction
	initialize_dirs = DISP_DIR_LEFT|DISP_DIR_FLIP

