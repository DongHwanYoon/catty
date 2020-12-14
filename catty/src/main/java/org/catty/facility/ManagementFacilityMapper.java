package org.catty.facility;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface ManagementFacilityMapper {
    public List<ManagementFacility> selectManagementFacilityList(ManagementFacility managementFacility) throws Exception;
    public ManagementFacility selectManagementFacility(ManagementFacility managementFacility) throws Exception;
    public void insertManagementFacility(ManagementFacility managementFacility) throws Exception;
    public void updateManagementFacility(ManagementFacility managementFacility) throws Exception;
    public void deleteManagementFacility(ManagementFacility managementFacility) throws Exception;
}