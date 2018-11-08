package com.bit.bnb.rooms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.rooms.dao.RoomsDAO;
import com.bit.bnb.rooms.model.RoomsVO;

@Service
public class RoomsLIstService {

	@Autowired
	RoomsDAO roomsDAO;

	public List<RoomsVO> getRoomsList(RoomsVO rv) {
		return roomsDAO.selectRooms(rv);
	}
}
