import { createSignal, createResource, For } from "solid-js";
import CatItem from "./CatItem";
import './CatList.css'
import Filters from "./Filters";
import Pagy from "./../Pagy";

const CatList = ({ serviceType }) => {
  const [page, setPage] = createSignal(1)
  const [pagy, setPagy] = createSignal({})
  const [requestParams, setRequestParams] = createSignal({...{page :page(), breed: []}});

  const serializeQuery = (params, prefix) => {
    const query = Object.keys(params).map((key) => {
      const value  = params[key];

      if (params.constructor === Array)
        key = `${prefix}[]`;
      else if (params.constructor === Object)
        key = (prefix ? `${prefix}[${key}]` : key);

      if (typeof value === 'object')
        return serializeQuery(value, key);
      else
        return `${key}=${encodeURIComponent(value)}`;
    });

    return [].concat.apply([], query).join('&');
  }

  const fetchCats = async () => {
    const responseData = await fetch(`http://localhost:3000/business_logic/${serviceType}/cats` + '?' + serializeQuery(requestParams()))
                         .then((response) => response.json())

    setPagy(responseData.pagy)
    setPage(responseData.pagy.page)
    return responseData.data
  }

  const fetchFilters = async () => {
    const responseData = await fetch(`http://localhost:3000/business_logic/${serviceType}/cats/filters`)
                               .then((response) => response.json())

    return responseData.filters
  }

  const updateParams = (params) => {
    setRequestParams({...{...requestParams(), ...params }})
  }

  const [filtersData] = createResource(fetchFilters)
  const [cats] = createResource(requestParams, fetchCats)

  return (
    <div class='CatListWrap'>
      <Filters filters={filtersData} updateParams={updateParams} requestParams={requestParams}/>
      <div>
        <div class='CatList'>
          <For each={cats()} fallback={<div>No results</div>}>
            {(catItem) => <CatItem cat={catItem} />}
          </For>
        </div>
        <Pagy pagy={pagy} updateParams={updateParams}/>
      </div>
    </div>
  )
}

export default CatList
