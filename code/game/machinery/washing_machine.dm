#define EMPTY_OPEN		1
#define EMPTY_CLOSED	2
#define FULL_OPEN		3
#define FULL_CLOSED		4
#define FULL_PROCESS	5
#define BLOOD_OPEN		6
#define BLOOD_CLOSED	7
#define BLOOD_PROCESS	8

/obj/machinery/washing_machine
	name = "Washing Machine"
	desc = "Gets rid of those pesky bloodstains, or your money back!"
	icon = 'icons/obj/machines/washing_machine.dmi'
	icon_state = "wm_10"
	density = TRUE
	anchored = TRUE
	var/state = EMPTY_OPEN
	var/panel = FALSE
	var/hacked = FALSE
	var/gibs_ready = FALSE
	var/list/crayons

/obj/machinery/washing_machine/verb/start()
	set name = "Start Washing"
	set category = "Object"
	set src in oview(1)

	if(!isliving(usr)) //ew ew ew usr, but it's the only way to check.
		return
	if(state != FULL_CLOSED)
		to_chat(usr, "The washing machine cannot run in this state.")
		return
	if(locate(/mob, contents))
		state = BLOOD_PROCESS
	else
		state = FULL_PROCESS
	update_icon()
	sleep(200)
	for(var/atom/A in contents)
		A.clean_blood()

	//Tanning!
	for(var/obj/item/stack/sheet/hairlesshide/leather in contents)
		new /obj/item/stack/sheet/wetleather(src, leather.amount)
		qdel(leather)
	if(crayons)
		var/wash_color
		if(istype(crayon, /obj/item/toy/crayon))
			var/obj/item/toy/crayon/CR = crayon
			wash_color = CR.colourName
		else if(istype(crayon, /obj/item/stamp))
			var/obj/item/stamp/ST = crayon
			wash_color = ST.item_color
		if(wash_color)
			var/new_jumpsuit_icon_state = ""
			var/new_jumpsuit_item_state = ""
			var/new_jumpsuit_name = ""
			var/new_glove_icon_state = ""
			var/new_glove_item_state = ""
			var/new_glove_name = ""
			var/new_bandana_icon_state = ""
			var/new_bandana_item_state = ""
			var/new_bandana_name = ""
			var/new_shoe_icon_state = ""
			var/new_shoe_name = ""
			var/new_sheet_icon_state = ""
			var/new_sheet_name = ""
			var/new_softcap_icon_state = ""
			var/new_softcap_name = ""
			var/new_desc = "The colors are a bit dodgy."
			for(var/T in typesof(/obj/item/clothing/under))
				var/obj/item/clothing/under/J = new T
				if(wash_color == J.item_color)
					new_jumpsuit_icon_state = J.icon_state
					new_jumpsuit_item_state = J.item_state
					new_jumpsuit_name = J.name
					qdel(J)
					break
				qdel(J)
			for(var/T in typesof(/obj/item/clothing/gloves/color))
				var/obj/item/clothing/gloves/color/G = new T
				if(wash_color == G.item_color)
					new_glove_icon_state = G.icon_state
					new_glove_item_state = G.item_state
					new_glove_name = G.name
					qdel(G)
					break
				qdel(G)
			for(var/T in typesof(/obj/item/clothing/shoes))
				var/obj/item/clothing/shoes/S = new T
				if(wash_color == S.item_color)
					new_shoe_icon_state = S.icon_state
					new_shoe_name = S.name
					qdel(S)
					break
				qdel(S)
			for(var/T in typesof(/obj/item/clothing/mask/bandana))
				var/obj/item/clothing/mask/bandana/M = new T
				if(wash_color == M.item_color)
					new_bandana_icon_state = M.icon_state
					new_bandana_item_state = M.item_state
					new_bandana_name = M.name
					qdel(M)
					break
				qdel(M)
			for(var/T in typesof(/obj/item/bedsheet))
				var/obj/item/bedsheet/B = new T
				if(wash_color == B.item_color)
					new_sheet_icon_state = B.icon_state
					new_sheet_name = B.name
					qdel(B)
					break
				qdel(B)
			for(var/T in typesof(/obj/item/clothing/head/soft))
				var/obj/item/clothing/head/soft/H = new T
				if(wash_color == H.item_color)
					new_softcap_icon_state = H.icon_state
					new_softcap_name = H.name
					qdel(H)
					break
				qdel(H)
			if(new_jumpsuit_icon_state && new_jumpsuit_item_state && new_jumpsuit_name)
				for(var/obj/item/clothing/under/J in contents)
					if(!J.dyeable)
						continue
					J.item_state = new_jumpsuit_item_state
					J.icon_state = new_jumpsuit_icon_state
					J.item_color = wash_color
					J.name = new_jumpsuit_name
					J.desc = new_desc
			if(new_glove_icon_state && new_glove_item_state && new_glove_name)
				for(var/obj/item/clothing/gloves/color/G in contents)
					if(!G.dyeable)
						continue
					G.item_state = new_glove_item_state
					G.icon_state = new_glove_icon_state
					G.item_color = wash_color
					G.name = new_glove_name
					if(!istype(G, /obj/item/clothing/gloves/color/black/thief))
						G.desc = new_desc
			if(new_shoe_icon_state && new_shoe_name)
				for(var/obj/item/clothing/shoes/S in contents)
					if(!S.dyeable)
						continue
					if(istype(S, /obj/item/clothing/shoes/orange))
						var/obj/item/clothing/shoes/orange/prison_shoes = S
						if(prison_shoes.shackles)
							prison_shoes.shackles = null
							prison_shoes.slowdown = SHOES_SLOWDOWN
							new /obj/item/restraints/handcuffs(src)
					S.icon_state = new_shoe_icon_state
					S.item_color = wash_color
					S.name = new_shoe_name
					S.desc = new_desc
			if(new_bandana_icon_state && new_bandana_name)
				for(var/obj/item/clothing/mask/bandana/M in contents)
					if(!M.dyeable)
						continue
					M.item_state = new_bandana_item_state
					M.icon_state = new_bandana_icon_state
					M.item_color = wash_color
					M.name = new_bandana_name
					M.desc = new_desc
			if(new_sheet_icon_state && new_sheet_name)
				for(var/obj/item/bedsheet/B in contents)
					B.icon_state = new_sheet_icon_state
					B.item_color = wash_color
					B.name = new_sheet_name
					B.desc = new_desc
			if(new_softcap_icon_state && new_softcap_name)
				for(var/obj/item/clothing/head/soft/H in contents)
					if(!H.dyeable)
						continue
					H.icon_state = new_softcap_icon_state
					H.item_color = wash_color
					H.name = new_softcap_name
					H.desc = new_desc
		QDEL_NULL(crayon)

	if(locate(/mob, contents))
		state = BLOOD_CLOSED
		gibs_ready = TRUE
	else
		state = FULL_CLOSED
	update_icon()

/obj/machinery/washing_machine/verb/climb_out()
	set name = "Climb out"
	set category = "Object"
	set src in usr.loc

	sleep(20)
	if(state in list(EMPTY_OPEN, FULL_OPEN, BLOOD_OPEN))
		usr.loc = src.loc


/obj/machinery/washing_machine/update_icon()
	icon_state = "wm_[state][panel]"

/obj/machinery/washing_machine/attackby(obj/item/W, mob/user, params)
	/*if(istype(W,/obj/item/screwdriver))
		panel = !panel
		to_chat(user, span_notice("you [panel ? ")open" : "close"] the [src]'s maintenance panel")*/
	if(default_unfasten_wrench(user, W))
		add_fingerprint(user)
		power_change()
		return
	if(istype(W, /obj/item/toy/crayon) || istype(W, /obj/item/stamp))
		if(state in list(EMPTY_OPEN, FULL_OPEN, BLOOD_OPEN))
			if(!crayon)
				add_fingerprint(user)
				user.drop_transfer_item_to_loc(W, src)
				crayon = W
				update_icon()
			else
				return ..()
		else
			return ..()
	else if(istype(W,/obj/item/grab))
		if((state == EMPTY_OPEN) && hacked)
			var/obj/item/grab/G = W
			if(ishuman(G.assailant) && iscorgi(G.affecting))
				add_fingerprint(user)
				G.affecting.loc = src
				qdel(G)
				state = FULL_OPEN
			update_icon()
		else
			return ..()
	else if(istype(W, /obj/item/stack/sheet/hairlesshide) || \
		istype(W, /obj/item/clothing/under) || \
		istype(W, /obj/item/clothing/mask) || \
		istype(W, /obj/item/clothing/head) || \
		istype(W, /obj/item/clothing/gloves) || \
		istype(W, /obj/item/clothing/shoes) || \
		istype(W, /obj/item/clothing/suit) || \
		istype(W, /obj/item/bedsheet))

		//YES, it's hardcoded... saves a var/can_be_washed for every single clothing item.
		if(istype(W, /obj/item/clothing/suit/space))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/suit/syndicatefake))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/suit/cyborg_suit))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/suit/bomb_suit))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/suit/armor))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/suit/armor))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/mask/gas))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/mask/cigarette))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/head/syndicatefake))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/head/helmet))
			to_chat(user, "This item does not fit.")
			return
		if(istype(W, /obj/item/clothing/gloves/furgloves))
			to_chat(user, "This item does not fit.")
			return
		if(W.flags & NODROP) //if "can't drop" item
			to_chat(user, span_notice("\The [W] is stuck to your hand, you cannot put it in the washing machine!"))
			return
		if(contents.len < 5)
			if(state in list(EMPTY_OPEN, FULL_OPEN))
				add_fingerprint(user)
				user.drop_transfer_item_to_loc(W, src)
				state = FULL_OPEN
			else
				to_chat(user, span_notice("You can't put the item in right now."))
		else
			to_chat(user, span_notice("The washing machine is full."))
		update_icon()
	else
		return ..()

/obj/machinery/washing_machine/attack_hand(mob/user)
	add_fingerprint(user)
	switch(state)
		if(EMPTY_OPEN)
			state = EMPTY_CLOSED
		if(EMPTY_CLOSED)
			state = EMPTY_OPEN
			for(var/atom/movable/O in contents)
				O.loc = src.loc
		if(FULL_OPEN)
			state = FULL_CLOSED
		if(FULL_CLOSED)
			state = FULL_OPEN
			for(var/atom/movable/O in contents)
				O.loc = src.loc
			crayon = null
			state = EMPTY_OPEN
		if(FULL_PROCESS)
			to_chat(user, span_warning("The [src] is busy."))
		if(BLOOD_OPEN)
			state = BLOOD_CLOSED
		if(BLOOD_CLOSED)
			if(gibs_ready)
				gibs_ready = FALSE
				if(locate(/mob, contents))
					var/mob/M = locate(/mob, contents)
					M.gib()
			for(var/atom/movable/O in contents)
				O.loc = src.loc
			crayon = null
			state = EMPTY_OPEN
	update_icon()

/obj/machinery/washing_machine/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/metal(drop_location(), 2)
	qdel(src)

#undef EMPTY_OPEN
#undef EMPTY_CLOSED
#undef FULL_OPEN
#undef FULL_CLOSED
#undef FULL_PROCESS
#undef BLOOD_OPEN
#undef BLOOD_CLOSED
#undef BLOOD_PROCESS
