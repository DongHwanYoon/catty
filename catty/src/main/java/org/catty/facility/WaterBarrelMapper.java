package org.catty.facility;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface WaterBarrelMapper {
    public List<WaterBarrel> selectWaterBarrelList(WaterBarrel waterBarrel) throws Exception;
    public WaterBarrel selectWaterBarrel(WaterBarrel waterBarrel) throws Exception;
    public void insertWaterBarrel(WaterBarrel waterBarrel) throws Exception;
    public void updateWaterBarrel(WaterBarrel waterBarrel) throws Exception;
    public void deleteWaterBarrel(WaterBarrel waterBarrel) throws Exception;
}