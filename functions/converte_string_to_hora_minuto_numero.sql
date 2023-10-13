function parseStringToInt(horario) {
	let [hora, minuto] = horario.split(':').map(v => parseInt(v));
	if (!minuto) {
		minuto = 0;
	}
	return minuto + (hora * 60);
};
