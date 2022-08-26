extends Popup

func _ready() -> void:
	get_node("SettingTabs/Audio/MarginContainer/AudioSettings/EffectVolSlider").value = SaveSettings.settings["effect_volume"]
	get_node("SettingTabs/Audio/MarginContainer/AudioSettings/MusicVolSlider").value = SaveSettings.settings["music_volume"]
	get_node("SettingTabs/Audio/MarginContainer/AudioSettings/MasterVolSlider").value = SaveSettings.settings["master_volume"]

func _on_MasterVolSlider_value_changed(value) -> void:
	SaveSettings.settings["master_volume"] = value
	SceneTransistor.set_volume()


func _on_MusicVolSlider_value_changed(value) -> void:
	SaveSettings.settings["music_volume"] = value
	SceneTransistor.set_volume()


func _on_EffectVolSlider_value_changed(value) -> void:
	SaveSettings.settings["effect_volume"] = value
	SceneTransistor.set_volume()


func _on_ExitButoon_pressed() -> void:
	SaveSettings.write()
	self.visible = false
