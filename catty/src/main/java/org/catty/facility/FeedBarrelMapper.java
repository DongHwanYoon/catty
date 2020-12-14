package org.catty.facility;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface FeedBarrelMapper {
    public List<FeedBarrel> selectFeedBarrelList(FeedBarrel feedBarrel) throws Exception;
    public FeedBarrel selectFeedBarrel(FeedBarrel feedBarrel) throws Exception;
    public void insertFeedBarrel(FeedBarrel feedBarrel) throws Exception;
    public void updateFeedBarrel(FeedBarrel feedBarrel) throws Exception;
    public void deleteFeedBarrel(FeedBarrel feedBarrel) throws Exception;
}