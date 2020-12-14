package org.catty.inspectionlog;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface InspectionLogMapper {
    public List<InspectionLog> selectInspectionLogList(String term) throws Exception;
    public InspectionLog selectInspectionLog(InspectionLog inspectionLog) throws Exception;
    public int insertInspectionLog(InspectionLog inspectionLog) throws Exception;
    public int updateInspectionLog(InspectionLog inspectionLog) throws Exception;
    public int deleteInspectionLog(InspectionLog inspectionLog) throws Exception;
}