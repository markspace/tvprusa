smooth_bar_size = 8;
smooth_bar_spacing = 140;

hole_size = 3;
hole_padding = 8;

heated_bed_hole_spacing = 209;
heated_bed_hole_size = hole_size;
heated_bed_hole_padding = 7;
glass = 200;

lm8uu_holder_h = 14;
lm8uu_holder_w = 31;
lm8uu_holder_edge_offset = 5;

belt_clamp_hole_size = hole_size;
belt_clamp_hole_spacing = 17;
belt_clamp_centre_offset = 18;
belt_clamp_edge_offset = 15;

clip_w = 40;
clip_centre_offset = 55;
clip_glass_overlap = 5;

print_bottom_w = heated_bed_hole_spacing + 2 * ( hole_padding + heated_bed_hole_padding );
print_bottom_h = smooth_bar_spacing;

//translate( [print_bottom_w / 2, print_bottom_h / 2, 0] ) print_bottom();
translate( [print_bottom_w / 2, print_bottom_w / 2, 0] ) print_top();

module print_bottom()
{
	difference()
	{
		//Print plate bottom
		square( [print_bottom_w, print_bottom_h], center = true );

		// Print plate top mounting holes
		translate( [print_bottom_w / 2 - hole_padding, print_bottom_h / 2 - hole_padding, 0] ) hi_res_circle( hole_size / 2 );
		translate( [print_bottom_w / 2 - hole_padding, -( print_bottom_h / 2 - hole_padding ), 0] ) hi_res_circle( hole_size / 2 );
		translate( [-( print_bottom_w / 2 - hole_padding ), print_bottom_h / 2 - hole_padding, 0] ) hi_res_circle( hole_size / 2 );
		translate( [-( print_bottom_w / 2 - hole_padding ), -( print_bottom_h / 2 - hole_padding ), 0] ) hi_res_circle( hole_size / 2 );

		//LM8UU holders
		translate( [+( smooth_bar_spacing + smooth_bar_size ) / 2, print_bottom_h / 2 - lm8uu_holder_edge_offset - lm8uu_holder_h / 2, 0] ) lm8uu_holder( lm8uu_holder_w, lm8uu_holder_h, hole_size );
		translate( [-( smooth_bar_spacing + smooth_bar_size ) / 2, print_bottom_h / 2 - lm8uu_holder_edge_offset - lm8uu_holder_h / 2, 0] ) lm8uu_holder( lm8uu_holder_w, lm8uu_holder_h, hole_size );
		translate( [-( smooth_bar_spacing + smooth_bar_size ) / 2, -( print_bottom_h / 2 - lm8uu_holder_edge_offset - lm8uu_holder_h / 2 ), 0] ) lm8uu_holder( lm8uu_holder_w, lm8uu_holder_h, hole_size );
		translate( [+( smooth_bar_spacing + smooth_bar_size ) / 2, -( print_bottom_h / 2 - lm8uu_holder_edge_offset - lm8uu_holder_h / 2 ), 0] ) lm8uu_holder( lm8uu_holder_w, lm8uu_holder_h, hole_size );
		translate( [+( smooth_bar_spacing + smooth_bar_size ) / 2, 0, 0] ) lm8uu_holder( lm8uu_holder_w, lm8uu_holder_h, hole_size );

		//Y Belt Clamp
		translate( [belt_clamp_centre_offset, print_bottom_h / 2 - belt_clamp_edge_offset, 0] ) y_belt_clamp( belt_clamp_hole_spacing, belt_clamp_hole_size );
		translate( [belt_clamp_centre_offset, -( print_bottom_h / 2 - belt_clamp_edge_offset ), 0] ) y_belt_clamp( belt_clamp_hole_spacing, belt_clamp_hole_size );

	}
}

module print_top()
{
	difference()
	{
		//Print plate bottom
		square( [print_bottom_w, print_bottom_w], center = true );

		// Print plate top mounting holes
		translate( [print_bottom_w / 2 - hole_padding, print_bottom_h / 2 - hole_padding, 0] ) hi_res_circle( hole_size / 2 );
		translate( [print_bottom_w / 2 - hole_padding, -( print_bottom_h / 2 - hole_padding ), 0] ) hi_res_circle( hole_size / 2 );
		translate( [-( print_bottom_w / 2 - hole_padding ), print_bottom_h / 2 - hole_padding, 0] ) hi_res_circle( hole_size / 2 );
		translate( [-( print_bottom_w / 2 - hole_padding ), -( print_bottom_h / 2 - hole_padding ), 0] ) hi_res_circle( hole_size / 2 );

		//Heated Bed
		translate( [-heated_bed_hole_spacing / 2, -heated_bed_hole_spacing / 2, 0] ) hi_res_circle( heated_bed_hole_size / 2 );
		translate( [heated_bed_hole_spacing / 2, -heated_bed_hole_spacing / 2, 0] ) hi_res_circle( heated_bed_hole_size / 2 );
		translate( [-heated_bed_hole_spacing / 2, heated_bed_hole_spacing / 2, 0] ) hi_res_circle( heated_bed_hole_size / 2 );
		translate( [heated_bed_hole_spacing / 2, heated_bed_hole_spacing / 2, 0] ) hi_res_circle( heated_bed_hole_size / 2 );

		//Bulldog clip notches
		translate( [-clip_centre_offset, -( print_bottom_w / 4 + glass / 4 - clip_glass_overlap / 2), 0] ) clip_notch( clip_w, (print_bottom_w-glass ) / 2 + clip_glass_overlap + 1 );
		translate( [clip_centre_offset, -( print_bottom_w / 4 + glass / 4 - clip_glass_overlap / 2 ), 0] ) clip_notch( clip_w, ( print_bottom_w-glass ) / 2 + clip_glass_overlap + 1 );
		translate( [-clip_centre_offset, ( print_bottom_w / 4 + glass / 4 - clip_glass_overlap / 2 ), 0] ) clip_notch( clip_w, ( print_bottom_w - glass ) / 2 + clip_glass_overlap + 1 );
		translate( [clip_centre_offset, ( print_bottom_w / 4 + glass / 4 - clip_glass_overlap / 2 ), 0] ) clip_notch( clip_w, ( print_bottom_w-glass ) / 2 + clip_glass_overlap + 1 );
		
	}
}

module clip_notch( width, height )
{
	square( [width, height], center = true );
}

module lm8uu_holder( width, height, hole )
{
	translate( [-width / 2, -height / 2, 0] ) hi_res_circle( hole / 2 );
	translate( [width / 2, -height / 2, 0] ) hi_res_circle( hole / 2 );
	translate( [-width / 2, height / 2, 0] ) hi_res_circle( hole / 2 );
	translate( [ width / 2, height / 2, 0] ) hi_res_circle( hole / 2 );
}

module y_belt_clamp( hole_spacing, hole )
{
	translate( [hole_spacing / 2, 0, 0] ) hi_res_circle( hole / 2 );	
	translate( [-hole_spacing / 2, 0, 0] ) hi_res_circle( hole / 2 );
}

module hi_res_circle( radius = 3 )
{
	scale( [1 / 100, 1 / 100, 1] ) circle( radius * 100 );
}