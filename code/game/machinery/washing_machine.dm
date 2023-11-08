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
	var/list/items

/obj/machinery/washing_machine/verb/start()
	set name = "Start Washing"
	set category = "Object"
	set src in oview(1)

	if(!isliving(usr)) //ew ew ew usr, but it's the only way to check.
		return
	if(state != FULL_CLOSED)
		to_chat(usr, "The washing machine cannot run in this state.")
		return
	if(locate(/mob, items))
		state = BLOOD_PROCESS
	else
		state = FULL_PROCESS
	update_icon()
	sleep(200)
	for(var/atom/A in items)
		A.clean_blood()

	//Tanning!
	for(var/obj/item/stack/sheet/hairlesshide/leather in items)
		new /obj/item/stack/sheet/wetleather(src, leather.amount)
		qdel(leather)
	for(crayon in crayons)
		var/list/wash_color[index] = list()
		if(istype(crayon, /obj/item/toy/crayon)) // herehere
			var/obj/item/toy/crayon/CR = crayon
			wash_color[CR.colourName] += CR.colourName
		else if(istype(crayon, /obj/item/stamp)) ///herehere
			var/obj/item/stamp/ST = crayon
			wash_color[ST.item_color] += ST.item_color
		for(new_color in wash_color[index])
			var/list/new_jumpsuit_icon_state = list()
			var/list/new_jumpsuit_item_state = list()
			var/list/new_jumpsuit_name = list()
			var/list/new_glove_icon_state = list()
			var/list/new_glove_item_state = list()
			var/list/new_glove_name = list()
			var/list/new_bandana_icon_state = list()
			var/list/new_bandana_item_state = list()
			var/list/new_bandana_name = list()
			var/list/new_shoe_icon_state = list()
			var/list/new_shoe_name = list()
			var/list/new_sheet_icon_state = list()
			var/list/new_sheet_name = list()
			var/list/new_softcap_icon_state = list()
			var/list/new_softcap_name = list()
			var/new_desc = "The colors are a bit dodgy."
			for(var/T in typesof(/obj/item/clothing/under))
				var/obj/item/clothing/under/J = new T
				if(new_color == J.item_color)
					new_jumpsuit_icon_state[new_color] += J.icon_state
					new_jumpsuit_item_state[new_color] += J.item_state
					new_jumpsuit_name[new_color] += J.name
					qdel(J)
					break
				qdel(J)
			for(var/T in typesof(/obj/item/clothing/gloves/color))
				var/obj/item/clothing/gloves/color/G = new T
				if(new_color == G.item_color)
					new_glove_icon_state[new_color] += G.icon_state
					new_glove_item_state[new_color] += G.item_state
					new_glove_name[new_color] += G.name
					qdel(G)
					break
				qdel(G)
			for(var/T in typesof(/obj/item/clothing/shoes))
				var/obj/item/clothing/shoes/S = new T
				if(new_color == S.item_color)
					new_shoe_icon_state[new_color] += S.icon_state
					new_shoe_name[new_color] += S.name
					qdel(S)
					break
				qdel(S)
			for(var/T in typesof(/obj/item/clothing/mask/bandana))
				var/obj/item/clothing/mask/bandana/M = new T
				if(new_color == M.item_color)
					new_bandana_icon_state[new_color] += M.icon_state
					new_bandana_item_state[new_color] += M.item_state
					new_bandana_name[new_color] += M.name
					qdel(M)
					break
				qdel(M)
			for(var/T in typesof(/obj/item/bedsheet))
				var/obj/item/bedsheet/B = new T
				if(new_color == B.item_color)
					new_sheet_icon_state[new_color] += B.icon_state
					new_sheet_name[new_color] += B.name
					qdel(B)
					break
				qdel(B)
			for(var/T in typesof(/obj/item/clothing/head/soft))
				var/obj/item/clothing/head/soft/H = new T
				if(new_color == H.item_color)
					new_softcap_icon_state[new_color] += H.icon_state
					new_softcap_name[new_color] += H.name
					qdel(H)
					break
				qdel(H)
			if(new_jumpsuit_icon_state && new_jumpsuit_item_state && new_jumpsuit_name)
				for(var/obj/item/clothing/under/J in items)
					if(!J.dyeable)
						continue
					indexo = pick_n_take(wash_color[index])
					J.item_state = new_jumpsuit_item_state[indexo]
					J.icon_state = new_jumpsuit_icon_state[indexo]
					J.item_color = wash_color[indexo]
					J.name = new_jumpsuit_name[indexo]
					J.desc = new_desc
			if(new_glove_icon_state && new_glove_item_state && new_glove_name)
				for(var/obj/item/clothing/gloves/color/G in items)
					if(!G.dyeable)
						continue
					indexo = pick_n_take(wash_color[index])
					G.item_state = new_glove_item_state[indexo]
					G.icon_state = new_glove_icon_state[indexo]
					G.item_color = wash_color[indexo]
					G.name = new_glove_name[indexo]
					if(!istype(G, /obj/item/clothing/gloves/color/black/thief))
						G.desc = new_desc
			if(new_shoe_icon_state && new_shoe_name)
				for(var/obj/item/clothing/shoes/S in items)
					if(!S.dyeable)
						continue
					if(istype(S, /obj/item/clothing/shoes/orange))
						var/obj/item/clothing/shoes/orange/prison_shoes = S
						if(prison_shoes.shackles)
							prison_shoes.shackles = null
							prison_shoes.slowdown = SHOES_SLOWDOWN
							new /obj/item/restraints/handcuffs(src)
					indexo = pick_n_take(wash_color[index])
					S.icon_state = new_shoe_icon_state[indexo]
					S.item_color = wash_color[indexo]
					S.name = new_shoe_name[indexo]
					S.desc = new_desc
			if(new_bandana_icon_state && new_bandana_name)
				for(var/obj/item/clothing/mask/bandana/M in items)
					if(!M.dyeable)
						continue
					indexo = pick_n_take(wash_color[index])
					M.item_state = new_bandana_item_state[indexo]
					M.icon_state = new_bandana_icon_state[indexo]
					M.item_color = wash_color[indexo]
					M.name = new_bandana_name[indexo]
					M.desc = new_desc
			if(new_sheet_icon_state && new_sheet_name)
				for(var/obj/item/bedsheet/B in items)
					indexo = pick_n_take(wash_color[index])
					B.icon_state = new_sheet_icon_state[indexo]
					B.item_color = wash_color[indexo]
					B.name = new_sheet_name[indexo]
					B.desc = new_desc
			if(new_softcap_icon_state && new_softcap_name)
				for(var/obj/item/clothing/head/soft/H in items)
					if(!H.dyeable)
						continue
					indexo = pick_n_take(wash_color[index])
					H.icon_state = new_softcap_icon_state[indexo]
					H.item_color = wash_color[indexo]
					H.name = new_softcap_name[indexo]
					H.desc = new_desc
		crayons.Cut()
	if(locate(/mob, items))
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

/obj/machinery/washing_machine/multitool_act(mob/user, obj/item/I)
	. = TRUE
	if(!I.use_tool(src, user, 0, volume = I.tool_volume))
		return
	hacked = !hacked
	to_chat(user, span_notice("you [hacked ? "disable" : "enable"] the [src]'s safety safeguards"))

/obj/machinery/washing_machine/screwdriver_act(mob/user, obj/item/I)
	if(!I.use_tool(src, user, 0, volume = 0))
		return FALSE
	if(state != FULL_PROCESS)
		panel = !panel
		to_chat(user, span_notice("you [panel ? "open" : "close"] the [src]'s maintenance panel"))
		return TRUE

/obj/machinery/washing_machine/update_icon()
	icon_state = "wm_[state][panel]"

/obj/machinery/washing_machine/attackby(obj/item/W, mob/user, params)
	if(default_unfasten_wrench(user, W))
		add_fingerprint(user)
		power_change()
		return
	if(istype(W, /obj/item/toy/crayon) || istype(W, /obj/item/stamp))
		if(state in list(EMPTY_OPEN, FULL_OPEN, BLOOD_OPEN))
			if(crayons.len <= 6)
				add_fingerprint(user)
				user.drop_transfer_item_to_loc(W, src)
				crayons += W
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
				item += G.affecting
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
		if(items.len < 5)
			if(state in list(EMPTY_OPEN, FULL_OPEN))
				add_fingerprint(user)
				items += W
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
			for(var/atom/movable/O in items)
				O.loc = src.loc
				items -= O
		if(FULL_OPEN)
			state = FULL_CLOSED
		if(FULL_CLOSED)
			state = FULL_OPEN
			for(var/atom/movable/O in items)
				O.loc = src.loc
				items -= O
			crayons.Cut()
			state = EMPTY_OPEN
		if(FULL_PROCESS)
			to_chat(user, span_warning("The [src] is busy."))
		if(BLOOD_OPEN)
			state = BLOOD_CLOSED
		if(BLOOD_CLOSED)
			if(gibs_ready)
				gibs_ready = FALSE
				if(locate(/mob, items))
					var/mob/M = locate(/mob, items)
					M.gib()
			for(var/atom/movable/O in items)
				O.loc = src.loc
				items -= O
			crayons.Cut()
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
