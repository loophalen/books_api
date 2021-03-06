class BooksList extends React.Component {
  render (){
    return (
      <table>
        <tbody>
        {this.props.books.map((book, index) => {
          return (

            <tr >
              <td className='list' onClick={()=>

              { this.props.getBook(book); this.props.toggleState('bookShowAvailable', 'booksListAvailable')}
              }>
                <img src={book.image} alt={book.title} />
              </td>
              <td className='book' onClick={()=> { this.props.getBook(book); this.props.toggleState('booksListAvailable', 'bookAvailable')}}>
                <h3> {book.title} </h3>
              </td>
              <td>
                  <button className='button is-warning is-small'
                  onClick={()=>
                  { this.props.getBook(book); this.props.toggleState('booksListAvailable', 'bookAvailable')}}
                  >Edit</button>
              </td>
              <td>
                  <button className='button is-danger is-small' onClick={() => this.props.deleteBook(book, index)}>Delete</button>
              </td>
            </tr>
          )
        })}
        </tbody>
      </table>
    )
  }
}
