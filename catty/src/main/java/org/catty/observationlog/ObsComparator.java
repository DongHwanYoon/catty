package org.catty.observationlog;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;

public class ObsComparator implements Comparator<ObservationLog> {
	@Override
	public int compare(ObservationLog o1, ObservationLog o2) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일 H:m:s");
		LocalDateTime t1 = LocalDateTime.parse(o1.getRegistrateDate(), formatter);
		LocalDateTime t2 = LocalDateTime.parse(o2.getRegistrateDate(), formatter);
		
		return t2.compareTo(t1);
	}
}
