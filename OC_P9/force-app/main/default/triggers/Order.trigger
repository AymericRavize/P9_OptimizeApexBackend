trigger Order on Order (before update, after update) {

	if (Trigger.isUpdate) {//cas où l'on a une mise à jour
        if (Trigger.isBefore ) {//si cela doit s'effectuer avant (la mise à jour)
		TriggerOrderHamdler.nestAmountMaj(Trigger.New);
		}
	else{//dans les autres cas (après l'update)

	TriggerOrderHamdler.ChiffreAffaireMaj(Trigger.New);

	}
	}
}
