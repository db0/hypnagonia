extends "res://tests/UTCommon.gd"

func before_each():
	cfc._setup()
	setup_hypnagonia_testing()

func after_each():
	teardown_hypnagonia_testing()
	yield(yield_for(0.1), YIELD)

