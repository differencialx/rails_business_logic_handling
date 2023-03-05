import { createSignal } from "solid-js";

const Pagy = ({ pagy, updateParams }) => {
  const handleClick = (number) => {
    updateParams({ page: number })
  }

  return (
    <div>
      <For each={[...Array(pagy().last).keys()]}>
        {
          (number) => <button onClick={() => handleClick(number + 1)}>{number + 1}</button>
        }
      </For>
    </div>
  )
}

export default Pagy
