// LAMIA
/obj/item/bodypart/lamian_tail
	name = "lamia"
	desc = ""
	icon = 'icons/mob/taurs.dmi'
	icon_state = ""
	attack_verb = list("hit")
	max_damage = 300
	body_zone = BODY_ZONE_LAMIAN_TAIL
	body_part = LEGS
	body_damage_coeff = 1
	px_x = -16
	px_y = 12
	max_stamina_damage = 50
	subtargets = list(BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)
	grabtargets = list(BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)
	dismember_wound = /datum/wound/dismemberment/lamian_tail

	// Taur stuff!
	// offset_x forces the limb_icon to be shifted on x relative to the human (since these are >32x32)
	var/offset_x = -16
	// taur_icon_state sets which icon to use from icons/mob/taurs.dmi to render
	// (we don't use icon_state to avoid duplicate rendering on dropped organs)
	var/taur_icon_state = "naga_s"

	// We can Blend() a color with the base greyscale color, only some tails support this
	var/has_tail_color = FALSE
	var/color_blend_mode = BLEND_ADD
	var/tail_color = null

	// Clip Masks allow you to apply a clipping filter to some other parts of human rendering to avoid anything overlapping the tail.
	// Specifically: update_inv_cloak, update_inv_shirt, update_inv_armor, and update_inv_pants.
	var/icon/clip_mask_icon = 'icons/mob/taurs.dmi'
	var/clip_mask_state = "taur_clip_mask_def"
	// Instantiated at runtime for speed
	var/tmp/icon/clip_mask

/obj/item/bodypart/lamian_tail/New()
	. = ..()

	if(clip_mask_state)
		clip_mask = icon(icon = (clip_mask_icon || icon), icon_state = clip_mask_state)

/obj/item/bodypart/lamian_tail/get_limb_icon(dropped, hideaux = FALSE)
	// List of overlays
	. = list()

	var/image_dir = 0
	if(dropped)
		image_dir = SOUTH

	// This section is based on Virgo's human rendering, there may be better ways to do this now
	var/icon/tail_s = new/icon("icon" = icon, "icon_state" = taur_icon_state, "dir" = image_dir)
	if(has_tail_color)
		tail_s.Blend(tail_color, color_blend_mode)

	var/image/working = image(tail_s)
	// because these can overlap other organs, we need to layer slightly higher
	working.layer = -FRONT_MUTATIONS_LAYER
	working.pixel_x = offset_x

	. += working

/*********************************/
/* TAUR TYPES                    */
/*********************************/
GLOBAL_LIST_INIT(taur_types, subtypesof(/obj/item/bodypart/lamian_tail))

/obj/item/bodypart/lamian_tail/lamian_tail
	name = "Lamian Tail"

	offset_x = -16
	taur_icon_state = "altnaga_s"

	has_tail_color = TRUE
