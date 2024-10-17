// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Votacion {
    // Estructura para representar un candidato
    struct Candidato {
        string nombre; // Nombre del candidato
        uint votos;    // Número de votos que ha recibido
    }

    // Mapeo para almacenar candidatos por su índice
    mapping(uint => Candidato) public candidatos;
    // Mapeo para verificar si una dirección ya ha votado
    mapping(address => bool) public votantes;
    // Contador de la cantidad de candidatos
    uint public cantidadCandidatos;

    // Constructor para inicializar candidatos
    constructor(string[] memory nombresCandidatos) {
        for (uint i = 0; i < nombresCandidatos.length; i++) {
            agregarCandidato(nombresCandidatos[i]); // Agregar cada candidato
        }
    }

    // Función privada para agregar un candidato
    function agregarCandidato(string memory nombre) private {
        candidatos[cantidadCandidatos] = Candidato(nombre, 0); // Crear un nuevo candidato
        cantidadCandidatos++; // Incrementar el contador de candidatos
    }

    // Función para votar por un candidato
    function votar(uint indiceCandidato) public {
        require(!votantes[msg.sender], "Ya has votado."); // Verificar que el votante no haya votado
        require(indiceCandidato < cantidadCandidatos, "Candidato no valido."); // Verificar índice válido

        votantes[msg.sender] = true; // Marcar al votante como que ya votó
        candidatos[indiceCandidato].votos++; // Incrementar el conteo de votos del candidato
    }

    // Función para obtener el conteo de votos de un candidato
    function obtenerVotos(uint indiceCandidato) public view returns (uint) {
        require(indiceCandidato < cantidadCandidatos, "Candidato no valido."); // Verificar índice válido
        return candidatos[indiceCandidato].votos; // Devolver la cantidad de votos
    }
}
