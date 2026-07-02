Benchmark

Benchmark run from 2026-07-02 08:17:38.659773Z UTC

## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>Linux</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">AMD Ryzen 5 4600H with Radeon Graphics</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">12</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">30.71 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.20.0</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">28.5</td>
  </tr>
</table>

## Configuration

Benchmark suite executing with the following configuration:

<table style="width: 1%">
  <tr>
    <th style="width: 1%">:time</th>
    <td style="white-space: nowrap">10 s</td>
  </tr><tr>
    <th>:parallel</th>
    <td style="white-space: nowrap">1</td>
  </tr><tr>
    <th>:warmup</th>
    <td style="white-space: nowrap">1 s</td>
  </tr>
</table>

## Statistics



Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Deviation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">valid domain</td>
    <td style="white-space: nowrap; text-align: right">305.17 K</td>
    <td style="white-space: nowrap; text-align: right">3.28 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;429.28%</td>
    <td style="white-space: nowrap; text-align: right">3.12 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">4.74 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">disposable domain</td>
    <td style="white-space: nowrap; text-align: right">304.32 K</td>
    <td style="white-space: nowrap; text-align: right">3.29 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;239.15%</td>
    <td style="white-space: nowrap; text-align: right">3.09 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">4.84 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">nested domain</td>
    <td style="white-space: nowrap; text-align: right">256.84 K</td>
    <td style="white-space: nowrap; text-align: right">3.89 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;291.71%</td>
    <td style="white-space: nowrap; text-align: right">3.80 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">5.65 &micro;s</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">valid domain</td>
    <td style="white-space: nowrap;text-align: right">305.17 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">disposable domain</td>
    <td style="white-space: nowrap; text-align: right">304.32 K</td>
    <td style="white-space: nowrap; text-align: right">1.0x</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">nested domain</td>
    <td style="white-space: nowrap; text-align: right">256.84 K</td>
    <td style="white-space: nowrap; text-align: right">1.19x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">valid domain</td>
    <td style="white-space: nowrap">288 B</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">disposable domain</td>
    <td style="white-space: nowrap">288.00 B</td>
    <td>1.0x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">nested domain</td>
    <td style="white-space: nowrap">288 B</td>
    <td>1.0x</td>
  </tr>
</table>



Reduction Count

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">valid domain</td>
    <td style="white-space: nowrap">18</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">disposable domain</td>
    <td style="white-space: nowrap">18</td>
    <td>1.0x</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">nested domain</td>
    <td style="white-space: nowrap">18</td>
    <td>1.0x</td>
  </tr>
</table>