package com.bit.bnb.chatting.model;

public class ChatRoomVO{

    private String hostId;
    private String userId;
    private String roomsId;

    public String getHostId() {
        return hostId;
    }

    public void setHostId(String hostId) {
        this.hostId = hostId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRoomsId() {
        return roomsId;
    }

    public void setRoomsId(String roomsId) {
        this.roomsId = roomsId;
    }

    @Override
    public String toString() {
        return "ChatRoomVO{" +
                "hostId='" + hostId + '\'' +
                ", userId='" + userId + '\'' +
                ", roomsId='" + roomsId + '\'' +
                '}';
    }
}
