extends CombatEffect

# Do not set self_decreasing manually on the scene. This is handled in 
# CombatEntity._on_player_turn_started() in order to prevent this being removed
# at turn start, before checked against defense
# (which means the defense is going to be removed as well)
