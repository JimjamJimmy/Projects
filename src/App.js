import React, { useState } from 'react';

function App() {
  const [pokemon1, setPokemon1] = useState('');
  const [pokemon2, setPokemon2] = useState('');
  const [pokemon1Type, setPokemon1Type] = useState('none');
  const [pokemon2Type, setPokemon2Type] = useState('');

  const handlePokemon1Change = (event) => {
    setPokemon1(event.target.value);
  };

  const handlePokemon2Change = (event) => {
    setPokemon2(event.target.value);
  };



  function doAFetch() {
    fetch('https://pokeapi.co/api/v2/pokemon/' + pokemon1)
    .then(response => response.json())
    .then(response => response.types[0].type.name)
    .then(response => {console.log(response);
      return response;})
    .then(response => {setPokemon1Type(response)})

    fetch('https://pokeapi.co/api/v2/pokemon/' + pokemon2)
    .then(response => response.json())
    .then(response => response.types[0].type.name)
    .then(response => {console.log(response);
      return response;})
    .then(response => {setPokemon2Type(response)})
    .catch(error => {
      console.log('That didnt work. Heres a code or something:', error);
    });
    };


  return (
    <div>
      <div style={{ display: 'flex', flexDirection: 'row', gap: '10%', justifyContent: 'center', marginTop: '1%' }}>
        <input
          type="text"
          value={pokemon1}
          onChange={handlePokemon1Change}
          placeholder="Enter Pokemon 1"
        />
        <input
          type="text"
          value={pokemon2}
          onChange={handlePokemon2Change}
          placeholder="Enter Pokemon 2"
        />
      </div>
      <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'center', marginTop: '2%' }}>
        <img src={'https://freepngimg.com/thumb/pokemon/37475-6-pikachu-transparent-image.png'} alt="Sitting Pikachu" style={{ maxWidth: '300px' }} />
      </div>
      <div style={{display: 'flex', flexDirection: 'row', gap: '10%', marginTop: '2%', justifyContent: 'center'}}>
      <p style={{ marginBottom: '5px', fontSize: '18px', fontWeight: 'bold', color: '#77CC55' }}>
        Pokemon 1 type: {pokemon1Type}
      </p>
      <p style={{ marginBottom: '5px', fontSize: '18px', fontWeight: 'bold', color: '#55AAFF' }}>
        Pokemon 2 type: {pokemon2Type}
      </p>
      </div>
      <div style={{ display: 'flex', justifyContent: 'center', marginTop: '2%' }}>
        <button onClick={doAFetch}>Submit</button>
      </div>
    </div>
  );
}

export default App;


/* const getWeaknesses = (type) => {
    switch (type) {
        case 'Normal':
          return ['Fighting'];
        case 'Fire':
          return ['Water', 'Ground', 'Rock'];
        case 'Water':
          return ['Electric', 'Grass'];
        case 'Electric':
          return ['Ground'];
        case 'Grass':
          return ['Fire', 'Ice', 'Poison', 'Flying', 'Bug'];
        case 'Ice':
          return ['Fire', 'Fighting', 'Rock', 'Steel'];
        case 'Fighting':
          return ['Flying', 'Psychic', 'Fairy'];
        case 'Poison':
          return ['Ground', 'Psychic'];
        case 'Ground':
          return ['Water', 'Grass', 'Ice'];
        case 'Flying':
          return ['Electric', 'Ice', 'Rock'];
        case 'Psychic':
          return ['Bug', 'Ghost', 'Dark'];
        case 'Bug':
          return ['Fire', 'Flying', 'Rock'];
        case 'Rock':
          return ['Water', 'Grass', 'Fighting', 'Ground', 'Steel'];
        case 'Ghost':
          return ['Ghost', 'Dark'];
        case 'Dragon':
          return ['Ice', 'Dragon', 'Fairy'];
        case 'Dark':
          return ['Fighting', 'Bug', 'Fairy'];
        case 'Steel':
          return ['Fire', 'Fighting', 'Ground'];
        case 'Fairy':
          return ['Poison', 'Steel'];
        default:
          return [];
      }
    }; */