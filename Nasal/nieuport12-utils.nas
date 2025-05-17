#########################################################################################
#                                                                                       #
#  this script contains a number of utilities for use with the Nieuport-12 (YASim fdm)  #
#                                                                                       #
#########################################################################################

##############
# Define
#does what it says on the tin
var clamp = func(v, min, max) { v < min ? min : v > max ? max : v }

# ================================ Initalize ======================================
# Make sure all needed properties are present and accounted
# for, and that they have sane default values.

instrumentation_yawstring_Node = props.globals.getNode("instrumentation/yawstring[0]", 1);
instrumentation_yawstring_Node.setValue(0);

instrumentation_airstring_Node = props.globals.getNode("instrumentation/airstring[0]", 1);
instrumentation_airstring_Node.setValue(0);

instrumentation_yawstring_flutter_Node = props.globals.getNode("instrumentation/yawstring-flutter[0]", 1);
instrumentation_yawstring_flutter_Node.setValue(0);

generic_float0_Node = props.globals.getNode("sim/multiplay/generic/float[12]", 1);
generic_float0_Node.setValue(0);

generic_float1_Node = props.globals.getNode("sim/multiplay/generic/float[13]", 1);
generic_float1_Node.setValue(0);

generic_float2_Node = props.globals.getNode("sim/multiplay/generic/float[14]", 1);
generic_float2_Node.setValue(0);

props.globals.initNode("sim/model/livery/dirt-factor",0);

var engine_running_Node = props.globals.initNode("engines/engine[0]/running", 1, "BOOL");

initialize = func {

    print( "Initializing Nieuport-12 utilities ..." );

# initialize objects

    setprop("sim/model/position/latitude-deg", getprop("position/latitude-deg"));
    setprop("sim/model/position/longitude-deg", getprop("position/longitude-deg"));
    setprop("sim/model/position/altitude-ft", getprop("position/altitude-ft"));

#set listeners

# set it running on the next update cycle
    settimer( update, 0 );

    print( "... running Nieuport-12 utilities" );

} # end func

###
# ====================== end Initialization ========================================
###

###
# ==== this is the Main Loop which keeps everything updated ========================
##
	update = func {

		generic_float0_Node.setValue(instrumentation_yawstring_Node.getValue());
		generic_float1_Node.setValue(instrumentation_airstring_Node.getValue());
		generic_float2_Node.setValue(instrumentation_yawstring_flutter_Node.getValue());

		settimer( update, 0 );

	}# end main loop func

# ============================== end Main Loop =============================

# ============================== specify classes ===========================

# ============================== magneto stuff =============================

# ============================== pilot G stuff =============================

# ============================== smoke stuff ===============================

# ============================== engine Hobbs Meter ========================

# Fire it all up

setlistener("sim/signals/fdm-initialized", initialize);

# end 
