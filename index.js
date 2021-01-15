// pega o numero aleatorio do dado
// temporario
function dado() {
    var sorteio = Math.floor(Math.random() * 6 + 1);

    switch(sorteio){
        case 1:
            document.getElementById("face").src = "./imagens/face1.JPG";
            break;
        case 2:
            document.getElementById("face").src = "./imagens/face2.JPG";
            break;
        case 3:
            document.getElementById("face").src = "./imagens/face3.JPG";
            break;
        case 4:
            document.getElementById("face").src = "./imagens/face4.JPG";
            break;
        case 5:
            document.getElementById("face").src = "./imagens/face5.JPG";
            break;
        case 6:
            document.getElementById("face").src = "./imagens/face6.JPG";
            break;
        default:
            break;
    }

    // pega a posição do jogador
    var posicao = Math.floor(Math.random() * 20 + 1);
    var i = 1;
    while(i <= 20) {
        if(document.getElementById(`${i}`).className == "grid-pos") {
            document.getElementById(`${i}`).className = "grid-item";        
        }
        i++;
    }
    document.getElementById(`${posicao}`).className = "grid-pos";
}