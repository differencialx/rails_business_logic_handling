import { createSignal, For } from "solid-js";
import './Filters.css'

const Filters = ({ filters, updateParams, requestParams }) => {
  [requestFilters, setRequestFilters] = createSignal({ ...requestParams, ...{ breed: [], sort: 'name'}  })

  const handleChange = (e, filter) => {
    if (e.target.checked) {
      setRequestFilters({ ...requestFilters(), ...{ breed: [...new Set([...requestFilters().breed]), filter], page: 1 } })
    } else {
      const newSet = new Set([...requestFilters().breed])
      newSet.delete(filter)
      setRequestFilters({ ...requestFilters(), ...{ breed: [...newSet], page: 1 } })
    }
  }

  const handleRangeChange = (e) => {
    setRequestFilters({ ...requestFilters(), ...{ [e.target.name]: parseInt(e.target.value) } })
  }

  const handleSortChange = (e) => {
    setRequestFilters({ ...requestFilters(), ...{ sort: e.target.value } })
  }

  const handleClick = () => {
    updateParams(requestFilters())
  }

  return (
    <div class='Filters'>
      <For each={filters()?.breed}>
        {
          (filter) => (
            <div>
              <input id={filter} value={filter} type='checkbox' onChange={(e) => handleChange(e, filter)}>{filter}</input>
              <label htmlFor={filter}>{filter}</label>
            </div>
          )
        }
      </For>
      <label htmlFor='ageFrom'>Age From</label>
      <input id='ageFrom' name='age_from' type="number" min={filters()?.ageFrom} max={filters()?.ageTo} value={filters()?.ageFrom} onChange={handleRangeChange} />
      <label htmlFor='ageTo'>Age To</label>
      <input id='ageTo' name='age_to' type="number" min={filters()?.ageFrom} max={filters()?.ageTo} value={filters()?.ageTo} onChange={handleRangeChange} />
      <label htmlFor='weightFrom'>Weight From</label>
      <input id='weightFrom' name='weight_from' type="number" min={filters()?.weightFrom} max={filters()?.weightTo} value={filters()?.weightFrom} onChange={handleRangeChange} />
      <label htmlFor='weightTo'>Weight To</label>
      <input id='weightTo' name='weight_to' type="number" min={filters()?.weightFrom} max={filters()?.weightTo} value={filters()?.weightTo} onChange={handleRangeChange} />
      <label htmlFor='sort'>Sort by</label>
      <select onChange={handleSortChange}>
        <option value="name">Name Asc</option>
        <option value="-name">Name Desc</option>
        <option value="age">Age Asc</option>
        <option value="-age">Age Desc</option>
        <option value="weight">Weight Asc</option>
        <option value="-weight">Weight Desc</option>
        <option value="breed">Breed Asc</option>
        <option value="-breed">Breed Desc</option>
      </select>
      <button onClick={() => handleClick()}>Apply</button>
    </div>
  )
}

export default Filters
