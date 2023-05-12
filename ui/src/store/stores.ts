import { writable } from "svelte/store";

export const visibility = writable<boolean>(false);
export const browserMode = writable<boolean>(false);
export const resName = writable<string>("");
export const currentPage = writable('actions');

export const menuWideStore = writable({
    isMenuWide: false,
  });

export const toggleWideMenu = () => {
  menuWideStore.update((MenuWideData) => {
    return {
      ...MenuWideData,
      isMenuWide: !MenuWideData.isMenuWide,
    };
  });
};

interface DropdownItem {
  type: string;
  event?: string;
  label: string;
  inputtype?: string; 
}


interface ConfigItem {
  label: string;
  event?: string;
  type: string;
  dropdown?: DropdownItem[]; 
  perms?: string[];
  favorited?: boolean;
}


export const ACTIONS = writable<ConfigItem[]>(null);
export const ACTIONSBUTTONS = writable<ConfigItem>(null);
export const FAVORITES = writable<string[]>(null);


interface ResourceData {
  name: string;
  version: string;
  author: string;
  desc: string;
}

export const RESOURCES = writable<ResourceData[]>(null);
export const RESOURCESBUTTONS = writable<ResourceData>(null);
