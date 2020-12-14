package org.catty.observationlog;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface ObservationLogMapper {
    public List<ObservationLog> selectObservationLogList(ObservationLog observationLog) throws Exception;
    public ObservationLog selectObservationLog(ObservationLog observationLog) throws Exception;
    public int insertObservationLog(ObservationLog observationLog) throws Exception;
    public int updateObservationLog(ObservationLog observationLog) throws Exception;
    public int deleteObservationLog(ObservationLog observationLog) throws Exception;
}