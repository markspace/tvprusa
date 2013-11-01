OPENSCAD:=$(shell which openscad) -D variant=0 -D linear=1
TARGET=tvrrug2.0

PARTS= $(TARGET)/frame-vertex-with-foot.stl $(TARGET)/frame-vertex-without-foot.stl $(TARGET)/bar-clamp.stl $(TARGET)/belt-clamp.stl $(TARGET)/coupling.stl $(TARGET)/endstop-holder.stl $(TARGET)/herringbone-wadebits.stl $(TARGET)/9-tooth-pulley-TVRRUG.stl $(TARGET)/rod-clamp.stl $(TARGET)/SpringSeat.stl $(TARGET)/wade.stl $(TARGET)/x-carriage.stl $(TARGET)/x-end-idler.stl $(TARGET)/x-end-motor.stl $(TARGET)/z-motor-mount.stl $(TARGET)/spring.stl $(TARGET)/y-idler.stl $(TARGET)/ybrac-t.stl $(TARGET)/zizolator.stl

TARGETS=$(PARTS)
parts : $(TARGET) $(TARGETS)
help: 
	@echo Options:
	@echo make clean: deletes the stl directory with the output files
$(TARGET) :
	mkdir -p $(TARGET)
$(TARGET)/frame-vertex-with-foot.stl: SCADs/vertex.scad
	$(OPENSCAD) -D basefoot=true -o $@ SCADs/vertex.scad 
$(TARGET)/frame-vertex-without-foot.stl: SCADs/vertex.scad
	$(OPENSCAD)  -D basefoot=false -o $@ SCADs/vertex.scad
$(TARGET)/%.stl: SCADs/%.scad
	@echo "Processing $@"
	$(OPENSCAD) -o $@ $(subst $(TARGET),,SCADs$(subst .stl,.scad,$@))

clean :
	rm -rf $(TARGET)
