OPENSCAD:=$(shell which openscad) -D variant=0 -D linear=1
TARGET=tvrrug1.0

#PARTS= $(TARGET)/x-end-motor.stl $(TARGET)/x-end-idler.stl $(TARGET)/bar-clamp.stl
PARTS= $(TARGET)/frame-vertex-with-foot.stl $(TARGET)/frame-vertex-without-foot.stl $(TARGET)/bar-clamp.stl $(TARGET)/belt-clamp.stl $(TARGET)/bushing.stl $(TARGET)/coupling.stl $(TARGET)/endstop-holder.stl $(TARGET)/herringbone-wadebits.stl $(TARGET)/pulley.stl $(TARGET)/rod-clamp.stl $(TARGET)/SpringSeat.stl $(TARGET)/wade.stl $(TARGET)/x-carriage.stl $(TARGET)/x-end-idler.stl $(TARGET)/x-end-motor.stl $(TARGET)/y-motor-bracket.stl $(TARGET)/z-motor-mount.stl $(TARGET)/bed-spring_4off.stl

TARGETS=$(PARTS)
parts : $(TARGET) $(TARGETS)
help: 
	@echo Options:
	@echo make clean: deletes the stl directory with the output files
$(TARGET) :
	mkdir -p $(TARGET)
$(TARGET)/bar-clamp.stl: SCADs/bar-clamp.scad
	$(OPENSCAD) -o $@ SCADs/bar-clamp.scad 
$(TARGET)/frame-vertex-with-foot.stl: SCADs/vertex.scad
	$(OPENSCAD) -D basefoot=true -o $@ SCADs/vertex.scad 
$(TARGET)/frame-vertex-without-foot.stl: SCADs/vertex.scad
	$(OPENSCAD)  -D basefoot=false -o $@ SCADs/vertex.scad
$(TARGET)/bed-spring_4off.stl:
	cp STLs/bed-spring_4off.stl $@
$(TARGET)/%.stl: SCADs/%.scad
	@echo "Processing $@"
	$(OPENSCAD) -o $@ $(subst $(TARGET),,SCADs$(subst .stl,.scad,$@))

#$(PARTS) : $(TARGET)
#	@echo "Processing $@"
#	$(OPENSCAD) -s $(TARGET)/$@.stl $@.scad
clean :
	rm -rf $(TARGET)
