import React from 'react';
import axios from "axios"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faChevronLeft, faChevronRight } from '@fortawesome/free-solid-svg-icons'


export default class TradeForm extends React.Component {
  constructor(props) {
    super(props);
    const currentPage = 1

    this.state = {
      pokemonsToSend: [],
      pokemonsToReceive: [],
      pokemonCatalog: {},
      currentPage,
      loadingPokemons: true
    }
    this.fetchCatalog(currentPage)
  }

  fetchCatalog(page) {
    if(page == null) {
      return
    }

    const { pokemonCatalog } = this.state

    if(pokemonCatalog[page] != undefined) {
      this.setState({
        currentPage: page
      })

      return
    }

    this.setState({
      loadingPokemons: true
    })

    axios
      .get(`/api/v1/pokemons?page=${page}`)
      .then(response => {
        const nextCatalog = this.state.pokemonCatalog
        nextCatalog[page] = {
          pokemons: response.data.pokemons,
          nextPage: response.data.next_page,
          previousPage: response.data.previous_page,
        }

        this.setState({
          pokemonCatalog: nextCatalog,
          currentPage: page,
          loadingPokemons: false
        })
      })
      .catch(error => {
        console.log(error)
      })
  }

  renderListItens(pokemons) {
    let itensList = []

    pokemons.forEach((pokemon) => {
      itensList.push(
        <div key={pokemon.name} className='col-6 list-item'>
          <div key={pokemon.name} className='row list-item'>
            <div className="">
              <div
                className='pokemon-image-wrapper'
                style={{backgroundImage:`url(${pokemon.image_path})`}}
                data-toggle="tooltip" data-placement="bottom" title={pokemon.name}
              >
                <img
                  className="img-thumbnail pokemon-list-item-image"
                  src={pokemon.image_path}
                  alt={pokemon.name}
                />
              </div>
            </div>
            <div className="ml-2 pokemon-info">
              <p className="pokemon-name">
                <strong>Nome:</strong> {pokemon.name}
              </p>
              <p className="pokemon-experience">
              <strong>XP Base: </strong> {pokemon.base_experience}
              </p>
            </div>
          </div>
        </div>
      )
    })

    return itensList
  }

  renderCatalogOptions(){
    const { currentPage, pokemonCatalog, loadingPokemons } = this.state

    if(pokemonCatalog[currentPage] == undefined || loadingPokemons ) {
      return(
        <div className="container catalog-spinner d-flex justify-content-center align-middle">
            <div className="spinner-border"></div>
        </div>
      )
    }

    const pokemons = pokemonCatalog[currentPage].pokemons

    let catalogItens = []
    pokemons.forEach((pokemon) => {
      catalogItens.push(
        <div>
          <div>
            <div
              className='pokemon-image-wrapper'
              style={{backgroundImage:`url(${pokemon.image_path})`}}
              data-toggle="tooltip" data-placement="bottom" title={pokemon.name}
            >
              <img
                className="img-thumbnail pokemon-catalog-item-image"
                src={pokemon.image_path}
                alt={pokemon.name}
              />
            </div>
          </div>
          <div className="catalog-selector-wrapper">
            <button type="button" onClick={() => this.addPokemonToList("Send", pokemon)} className="btn btn-primary"><FontAwesomeIcon icon={faChevronLeft}/></button>
            <button type="button" onClick={() => this.addPokemonToList("Receive", pokemon)} className="btn btn-danger"><FontAwesomeIcon icon={faChevronRight}/></button>
          </div>
        </div>
      )
    })

    return catalogItens
  }

  renderCatalogPagination(){
    const { pokemonCatalog, currentPage } = this.state
    let nextPage = null
    let previousPage = null
    if(pokemonCatalog[currentPage] != undefined) {
      nextPage = pokemonCatalog[currentPage].nextPage
      previousPage = pokemonCatalog[currentPage].previousPage
    }

    return(
      <div className="d-flex justify-content-center row pagination">
          <button type="button" disabled={previousPage == null} onClick={() => this.fetchCatalog(previousPage) } className="btn btn-secondary"><FontAwesomeIcon icon={faChevronLeft}/>Anterior</button>
          <button type="button" disabled={nextPage == null} onClick={() => this.fetchCatalog(nextPage) } className="btn btn-secondary">Próxima<FontAwesomeIcon icon={faChevronRight}/></button>
      </div>
    )
  }

  addPokemonToList(list, pokemon){
    let pokemon_list = this.state[`pokemonsTo${list}`]
    if(pokemon_list.length >= 6) {
      return
    }

    const new_list = pokemon_list.concat(pokemon)

    if(list == 'Send') {
      this.setState({pokemonsToSend: new_list})
    } else if(list == 'Receive') {
      this.setState({pokemonsToReceive: new_list})
    }
  }

  render() {
    return (
      <div className="container">
        <form method="POST" action="/trades">
          <div className="row">
            <div className="col-6 inventory">
              <div className="w-100 text-center title">
                Estou enviando
              </div>
              <div className='poke-list-wrapper row'>

                {this.renderListItens(this.state.pokemonsToSend) }

              </div>
            </div>
            <div className="col-6 inventory">
              <div className="w-100 text-center title">
                Vou receber
              </div>
              <div className='poke-list-wrapper row'>

                {this.renderListItens(this.state.pokemonsToReceive) }

              </div>
            </div>
          </div>
        </form>
        <div className="pokemon-catalog-wrapper mt-4">
          <div className="row catalog">
            {this.renderCatalogOptions()}
          </div>

          {this.renderCatalogPagination()}
        </div>
      </div>
    );
  }
}

