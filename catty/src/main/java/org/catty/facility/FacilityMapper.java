package org.catty.facility;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface FacilityMapper {
    public Facility selectFacility(Facility facility) throws Exception;
    public int insertFacility(Facility facility) throws Exception;
    public int updateFacility(Facility facility) throws Exception;
    public int deleteFacility(Facility facility) throws Exception;
    public List<Facility> selectFacilityList(String term) throws Exception;
    public int insertTempFacility(Facility facility) throws Exception;
}