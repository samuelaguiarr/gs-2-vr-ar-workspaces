package com.github.gs.vrarworkspaces.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.ResponseEntity;

import com.github.gs.vrarworkspaces.controller.TemaController.TemaInfoResponse;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class TemaControllerTest {

	@LocalServerPort
	private int port;

	@Autowired
	private TestRestTemplate restTemplate;

	@Test
	void testGetInfo() {
		String url = "http://localhost:" + port + "/info";
		ResponseEntity<TemaInfoResponse> response = restTemplate.getForEntity(
			url, 
			TemaInfoResponse.class
		);

		assertNotNull(response.getBody());
		assertEquals("Ambientes de trabalho com Realidade Virtual ou Aumentada", response.getBody().tema());
		assertNotNull(response.getBody().membro1());
		assertNotNull(response.getBody().membro2());
		assertNotNull(response.getBody().descricao());
	}
}

