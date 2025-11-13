package com.github.gs.vrarworkspaces.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequestMapping("/info")
@Tag(name = "Tema", description = "Informações sobre o tema do projeto")
public class TemaController {

	@GetMapping
	@Operation(summary = "Retorna informações sobre o tema", description = "Retorna informações sobre o tema, membro do grupo e descrição")
	public TemaInfoResponse getInfo() {
		return new TemaInfoResponse(
			"Ambientes de trabalho com Realidade Virtual ou Aumentada",
			"Samuel Schaeffer Aguiar",
			"Esta API foi desenvolvida para suportar ambientes de trabalho inovadores que utilizam tecnologias de Realidade Virtual (VR) e Realidade Aumentada (AR). O objetivo é criar soluções que permitam colaboração remota imersiva, treinamentos virtuais, reuniões em espaços 3D e integração de elementos virtuais no ambiente físico de trabalho, transformando a forma como as equipes interagem e colaboram em um mundo cada vez mais digital e remoto."
		);
	}

	public record TemaInfoResponse(
		String tema,
		String membro1,
		String descricao
	) {}
}

