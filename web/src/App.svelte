<script lang="ts">
  import VisibilityProvider from './providers/VisibilityProvider.svelte';
  import Menu from './components/Menu.svelte';
  import { debugData } from './utils/debugData';

  debugData([
    {
      action: 'setVisible',
      data: true,
    },
  ]);
</script>

<main>
  <VisibilityProvider>
    <Menu />
  </VisibilityProvider>
</main>
