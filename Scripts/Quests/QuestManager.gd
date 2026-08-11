extends Node

enum QuestState {
	NOT_STARTED,
	IN_PROGRESS,
	COMPLETED
}

var quest_states = {}


func start_quest(quest_id: String):
	quest_states[quest_id] = QuestState.IN_PROGRESS
	print("Quest started: ", quest_id)


func complete_quest(quest_id: String):
	quest_states[quest_id] = QuestState.COMPLETED
	print("Quest completed: ", quest_id)


func get_quest_state(quest_id: String) -> QuestState:
	return quest_states.get(quest_id, QuestState.NOT_STARTED)


func is_quest_active(quest_id: String) -> bool:
	return get_quest_state(quest_id) == QuestState.IN_PROGRESS


func is_quest_completed(quest_id: String) -> bool:
	return get_quest_state(quest_id) == QuestState.COMPLETED
