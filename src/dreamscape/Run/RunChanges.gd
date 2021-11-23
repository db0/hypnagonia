# This class is responsible for storing changes that happen throughout the run
# such as unlocked NCEs, used artifacts, loading legacy elements from disk etc.
class_name RunChanges
extends Reference

# NCEs which have been unlocked to appear during this run
var unlocked_nce := {}
