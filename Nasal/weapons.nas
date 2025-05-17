
fire_MG = func {
	setprop("/controls/armament/trigger", 1);
}

stop_MG = func {
	setprop("/controls/armament/trigger", 0); 
}

var flash_trigger = props.globals.getNode("/controls/armament/trigger", 0);



##########################################################
# General initiatizers
#  
var ammo_weight=1.4/20; # 20 rounds of .303 180gr ammo weighs 1.4 pounds 
                    # per http://www.ammo-sale.com/proddetail.asp?prod=1699# 

var t_gun_ammo_count="/ai/submodels/submodel[0]/count";  
var t_gun_tracer_count="/ai/submodels/submodel[1]/count";
var mags_load="/controls/armament/lewismg[0]/magsleft";

reload_guns  = func {

  ## groundspeed=getprop("velocities/groundspeed-kt");
  ## engine_rpm=getprop("engines/engine/rpm");

  mg_installed=getprop("/controls/armament/lewismg[0]/install");
  mags_left=getprop("/controls/armament/lewismg[0]/magsleft");
  
  #only allow it if mg is mounted and full mags left
  if ( ( mg_installed and mags_left > 1 )  
         or getprop ( t_gun_ammo_count)== -1 ) {
    
    setprop ( t_gun_ammo_count, 65); #ammo
    setprop ( t_gun_tracer_count, 13); #tracer
    setprop ( mags_load, mags_left-1); #drum
    
    gui.popupTip ("Gun reloaded--65 rounds ammo drum.", 5)
    
  } else {
   
    gui.popupTip ("You have no full ammo drums left. Land for re-supply.",5)
  
  }

}

refill_drums  = func {

  groundspeed=getprop("/velocities/groundspeed-kt");
  engine_rpm=getprop("/engines/engine[0]/rpm");
  
  #only allow it if on ground, stopped OR if it's already set to unlimited mode
  if ( ( groundspeed < 5 and engine_rpm < 10 )  
         or getprop ( t_gun_ammo_count)== -1 ) {
    
    setprop ( t_gun_ammo_count, 65); #ammo
    setprop ( t_gun_tracer_count, 13); #tracer
    setprop ( mags_load, 5); #drum
    
    gui.popupTip ("5 Ammunition drums loaded--65 rounds each", 5)
    
  } else {
   
    gui.popupTip ("You must be on the ground and engines dead stopped to re-load the ammo drums.",5)
  
  }

}

##############################################################
#unlimited ammo
#
#For testing only, of course!
# 

unlimited_guns = func {

  groundspeed=getprop("/velocities/groundspeed-kt");
  engine_rpm=getprop("/engines/engine[0]/rpm");
  

    
    setprop ( t_gun_ammo_count, -1); #ammo r
    setprop ( t_gun_tracer_count, -1); #tracer r

   
    gui.popupTip ("Guns set to unlimited mode--definitely not realistic and only for testing!  Select 'Reload Guns' to revert to limited ammo.",7)
  
}

 
